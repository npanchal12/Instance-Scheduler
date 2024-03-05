import boto3
import time
import datetime
import json

dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table("asg_counts")
autoscaling = boto3.client("autoscaling")


def get_current_time():
    return datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def update_asg_configuration(asg_name, min_count, max_count, desired_count):
    autoscaling.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=min_count,
        MaxSize=max_count,
        DesiredCapacity=desired_count,
    )
    print(
        f"Updated {asg_name} configuration: desired_count={desired_count}, min_count={min_count}, max_count={max_count}"
    )


def get_asg_configuration(asg_name):
    asg_details = autoscaling.describe_auto_scaling_groups(
        AutoScalingGroupNames=[asg_name]
    )["AutoScalingGroups"][0]
    return (
        asg_details["MinSize"],
        asg_details["MaxSize"],
        asg_details["DesiredCapacity"],
    )


def update_asg_counts_table(asg_name, min_count, max_count, desired_count):
    table.put_item(
        Item={
            "asg_name": asg_name,
            "minimum_count": min_count,
            "maximum_count": max_count,
            "desired_count": desired_count,
            "last_updated": get_current_time(),
        }
    )
    print(f"Updated {asg_name} counts in DynamoDB table")


def record_asg_configurations():
    for asg in autoscaling.describe_auto_scaling_groups()["AutoScalingGroups"]:
        asg_name = asg["AutoScalingGroupName"]
        (
            current_min_count,
            current_max_count,
            current_desired_count,
        ) = get_asg_configuration(asg_name)
        item = table.get_item(Key={"asg_name": asg_name}).get("Item")
        if item:
            update_asg_counts_table(
                asg_name, current_min_count, current_max_count, item["desired_count"]
            )
        else:
            update_asg_counts_table(
                asg_name, current_min_count, current_max_count, current_desired_count
            )


def update_asg_configurations_to_zero():
    for asg in autoscaling.describe_auto_scaling_groups()["AutoScalingGroups"]:
        asg_name = asg["AutoScalingGroupName"]
        item = table.get_item(Key={"asg_name": asg_name}).get("Item")
        if item:
            desired_count = int(item["desired_count"])
            min_count = int(item["minimum_count"])
            max_count = int(item["maximum_count"])
            if desired_count > 0 and not any(
                tag["Key"] == "scheduler" and tag["Value"] == "false"
                for tag in asg["Tags"]
            ):
                update_asg_configuration(asg_name, 0, 0, 0)
                print(f"Updated {asg_name} configuration to zero in autoscaling")
                update_asg_counts_table(asg_name, min_count, max_count, desired_count)
                print(f"Updated {asg_name} configuration in DynamoDB")
            else:
                if desired_count == 0:
                    print(
                        f"Skipping {asg_name} configuration update in DynamoDB: desired_count is already zero"
                    )
                elif any(
                    tag["Key"] == "scheduler" and tag["Value"] == "false"
                    for tag in asg["Tags"]
                ):
                    print(
                        f"Skipping {asg_name} configuration update in DynamoDB: autoscaling updates are disabled"
                    )
        else:
            print(f"No configuration found for {asg_name}")


def lambda_handler(event, context):
    if "asg_scale" in event["body"]:
        asg_scale = json.loads(event["body"])["asg_scale"]
        if asg_scale == "scale-out":
            record_asg_configurations()
            time.sleep(30)
            update_asg_configurations_to_zero()
            message = "ASG configurations updated to zero"
            return {"statusCode": 200, "body": json.dumps(message)}
        elif asg_scale == "scale-in":
            for asg in autoscaling.describe_auto_scaling_groups()["AutoScalingGroups"]:
                asg_name = asg["AutoScalingGroupName"]
                item = table.get_item(Key={"asg_name": asg_name}).get("Item")
                if item:
                    desired_count = int(item["desired_count"])
                    min_count = int(item["minimum_count"])
                    max_count = int(item["maximum_count"])
                    if desired_count > 0:
                        update_asg_configuration(
                            asg_name, min_count, max_count, desired_count
                        )
                        print(
                            f"Updated {asg_name} configuration to desired count in autoscaling"
                        )
                        update_asg_counts_table(
                            asg_name, min_count, max_count, desired_count
                        )
                        print(
                            f"Updated {asg_name} configuration to desired count in DynamoDB"
                        )
                    else:
                        print(
                            f"Skipping {asg_name} configuration update in DynamoDB: desired_count is already zero"
                        )
                else:
                    print(f"No configuration found for {asg_name}")
            message = "ASG configurations updated to desired count"
            return {"statusCode": 200, "body": json.dumps(message)}
        else:
            message = 'Invalid request. Please use "asg_scale" parameter with value "scale-in" or "scale-out"'
            return {"statusCode": 400, "body": json.dumps(message)}
