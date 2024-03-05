import boto3
import itertools
import json


def start_stop_instances(instances, filtered_status):
    success = []
    failure = []
    # Ignore instances where `"scheduler": "false`
    filter_instances = (
        instance
        for instance in instances
        if not any(
            [
                tag["Key"] == "scheduler" and tag["Value"] == "false"
                for tag in instance.tags
            ]
        )
    )
    for instance in filter_instances:
        try:
            if filtered_status == "stopped":
                instance.start()
            elif filtered_status == "running":
                instance.stop()
            success.append(instance.id)
        except Exception as e:
            print(f"Failed togggling state of instance ID {instance.id}: {str(e)}")
            failure.append(instance.id)

    return success, failure


def lambda_handler(event, context):
    try:
        # Get JSON input from event
        payload = json.loads(event["body"])
        filtered_status = payload["status"]
        assert filtered_status == "stopped" or filtered_status == "running"

        # Get EC2 resource
        ec2 = boto3.resource("ec2")

        # Get instances matching the name filter
        name_instances = ec2.instances.filter(
            Filters=[
                {"Name": "tag:Name", "Values": ["non-asg-*", "Non-asg-*"]},
                {"Name": "instance-state-name", "Values": [filtered_status]},
            ]
        )

        # Get instances matching the scheduler filter
        scheduler_instances = ec2.instances.filter(
            Filters=[
                {"Name": "tag:scheduler", "Values": ["true"]},
                {"Name": "instance-state-name", "Values": [filtered_status]},
            ]
        )

        # Start or stop instances based on filtered status
        success, failure = start_stop_instances(
            itertools.chain(name_instances, scheduler_instances), filtered_status
        )

        message = ""
        status_code = 200

        if len(success) > 0:
            message = f"Instances {', '.join(success)} have been started or stopped as necessary."
        else:
            message = "No instances matched the filters."

        if len(failure) > 0:
            failure_message = (
                f"Instances {', '.join(failure)} could not be started or stopped."
            )
            status_code = 500
            message = f"{message}\n{failure_message}"

        print(message)
        return {"statusCode": status_code, "body": json.dumps(message)}

    except Exception as e:
        print(str(e))
        return {"statusCode": 500, "body": json.dumps(str(e))}
