import boto3
import json
import time
from datetime import datetime

def get_ecs_service_details(cluster_name, service_name):
    ecs_client = boto3.client('ecs')
    app_autoscaling_client = boto3.client('application-autoscaling')

    min_capacity = 1
    max_capacity = 10
    desired_count = 0
    task_count = 0

    try:
        # Fetch ECS service details
        response = ecs_client.describe_services(
            cluster=cluster_name,
            services=[service_name]
        )

        services = response.get('services', [])
        if not services:
            print(f"No services found in the cluster for {service_name}.")
            return None

        service = services[0]

        # Check 'scheduler' tag value
        scheduler_tag_value = 'false'
        for tag in service.get('tags', []):
            if tag['key'] == 'scheduler':
                scheduler_tag_value = tag['value']
                break

        # Skip processing if 'scheduler' tag is present and has a value of 'true'
        if scheduler_tag_value == 'true':
            print(f"Opting out service {service_name} in cluster {cluster_name} due to 'scheduler' tag.")
            return None

        # Continue with existing logic to fetch other details and extracting minimum and maximum number of tasks from the service's auto-scaling configuration
        service_registries = service.get('serviceRegistries', [])

        # Set default values when serviceRegistries is not present
        if service_registries:
            autoscaling_details = service_registries[0].get('scale', {})
            min_capacity = autoscaling_details.get('minimumHealthyPercent', min_capacity)
            max_capacity = autoscaling_details.get('maximumPercent', max_capacity)

        # Fetch Application Auto Scaling policies
        app_autoscaling_response = app_autoscaling_client.describe_scalable_targets(
            ServiceNamespace='ecs',
            ResourceIds=[f'service/{cluster_name}/{service_name}'],
            ScalableDimension='ecs:service:DesiredCount'
        )

        if 'ScalableTargets' in app_autoscaling_response:
            # Assuming a service has only one scalable target for simplicity
            scalable_targets = app_autoscaling_response['ScalableTargets']
            if scalable_targets:
                scalable_target = scalable_targets[0]
                min_capacity = scalable_target.get('MinCapacity', min_capacity)
                max_capacity = scalable_target.get('MaxCapacity', max_capacity)

        desired_count = service.get('desiredCount', 0)

        # Your existing code to fetch ECS task count
        task_count = get_ecs_task_count(services)

        return min_capacity, max_capacity, desired_count, task_count
    except Exception as e:
        print(f"Error fetching ECS service details for {service_name}: {e}")
        return None


def get_ecs_task_count(services):
    try:
        # Check if 'services' list is not empty
        if services and len(services) > 0:
            # Access the first element if available
            return services[0].get('desiredCount', 0)
        else:
            print(f"No services found or desiredCount not available.")
            return None
    except Exception as e:
        print(f"Error fetching ECS task count: {e}")
        return None


def get_all_clusters():
    ecs_client = boto3.client('ecs')

    try:
        response = ecs_client.list_clusters()
        return response['clusterArns']
    except Exception as e:
        print(f"Error fetching ECS clusters: {e}")
        return None

def get_all_services(cluster_name):
    ecs_client = boto3.client('ecs')

    try:
        response = ecs_client.list_services(cluster=cluster_name)
        return response['serviceArns']
    except Exception as e:
        print(f"Error fetching ECS services: {e}")
        return None

def put_item_to_dynamodb(cluster_name, service_name, min_capacity, max_capacity, desired_count, task_count):
    dynamodb_client = boto3.client('dynamodb')

    table_name = "ecs_task_counts"  # Replace with your actual table name

    try:
        # Get current timestamp for last updated time
        last_updated = datetime.utcnow().isoformat()

        # Combine service_name and cluster_name
        composite_service_name = f"{service_name}"

        response = dynamodb_client.put_item(
            TableName=table_name,
            Item={
                'cluster_name': {'S': cluster_name},
                'service_name': {'S': composite_service_name},
                'desired_count': {'S': str(desired_count)},  # Change to S (string)
                'min_capacity': {'S': str(min_capacity)},    # Change to S (string)
                'max_capacity': {'S': str(max_capacity)},    # Change to S (string)
                'task_count': {'N': str(task_count)},        # Keep as N (number)
                'last_updated': {'S': last_updated},
            }
        )
        print(f"Item added to DynamoDB for {service_name}: {response}")
    except Exception as e:
        print(f"Error putting item to DynamoDB for {service_name}: {e}")

def get_item_from_dynamodb(cluster_name, service_name):
    dynamodb_client = boto3.client('dynamodb')
    table_name = "ecs_task_counts"  # Replace with your actual table name

    try:
        composite_service_name = f"{service_name}"
        response = dynamodb_client.get_item(
            TableName=table_name,
            Key={
                'cluster_name': {'S': cluster_name},
                'service_name': {'S': composite_service_name}
            }
        )

        item = response.get('Item')
        if item:
            return {
                'min_capacity': int(item['min_capacity']['S']),
                'max_capacity': int(item['max_capacity']['S']),
                'desired_count': int(item['desired_count']['S']),
                'task_count': int(item['task_count']['N'])
            }
        else:
            print(f"No item found in DynamoDB for {service_name} in cluster {cluster_name}")
            return None
    except Exception as e:
        print(f"Error getting item from DynamoDB for {service_name}: {e}")
        return None

def update_ecs_service_desired_count(cluster_name, service_name, desired_count):
    ecs_client = boto3.client('ecs')

    try:
        response = ecs_client.update_service(
            cluster=cluster_name,
            service=service_name,
            desiredCount=desired_count
        )
        print(f"Updated ECS service {service_name} in cluster {cluster_name} desired count to {desired_count}.")
    except Exception as e:
        print(f"Error updating ECS service {service_name} in cluster {cluster_name} desired count: {e}")

def lambda_handler(event, context):
    clusters = get_all_clusters()

    if clusters:
        for cluster_arn in clusters:
            cluster_name = cluster_arn.split('/')[-1]
            
            # Check if 'scheduler' tag value is 'true'
            ecs_client = boto3.client('ecs')
            response = ecs_client.list_tags_for_resource(resourceArn=cluster_arn)
            scheduler_tag_value = 'false'
            for tag in response.get('tags', []):
                if tag['key'] == 'scheduler':
                    scheduler_tag_value = tag['value']
                    break
            
            if scheduler_tag_value == 'true':
                print(f"Opting out cluster {cluster_name} due to 'scheduler' tag.")
                continue

            print(f"Fetching details for cluster: {cluster_name}")

            services = get_all_services(cluster_name)

            if services:
                for service_arn in services:
                    service_name = service_arn.split('/')[-1]
                    print(f"Fetching details for service: {service_name}")

                    details = get_ecs_service_details(cluster_name, service_name)

                    if details:
                        min_capacity, max_capacity, desired_count, task_count = details
                        print(f"Min Capacity: {min_capacity}, Max Capacity: {max_capacity}, Desired Count: {desired_count}, Task Count: {task_count}")

                        # Combine service_name and cluster_name for DynamoDB item key
                        composite_service_name = f"{service_name}"

                        # Assume payload is present in the event
                        payload = event.get('body')

                        try:
                            payload_json = json.loads(payload)
                            ecs_scale = payload_json.get('ecs_scale')
                        except json.JSONDecodeError as e:
                            print(f"Error decoding JSON payload: {e}")
                            continue

                        if ecs_scale == 'scale-in':
                            # Record original values in DynamoDB
                            original_values = {
                                'min_capacity': min_capacity,
                                'max_capacity': max_capacity,
                                'desired_count': desired_count,
                                'task_count': task_count
                            }

                            put_item_to_dynamodb(cluster_name, composite_service_name, **original_values)
                            print(f"Original values recorded in DynamoDB for service {service_name} in cluster {cluster_name}")

                            # After 30 seconds, proceed to scale in
                            time.sleep(30)

                            # Scale in ECS service by setting desired count to zero without updating DynamoDB
                            update_ecs_service_desired_count(cluster_name, service_name, 0)

                        elif ecs_scale == 'scale-out':
                            # Revert to original values from DynamoDB
                            original_values = get_item_from_dynamodb(cluster_name, service_name)

                            if original_values:
                                print(f"Original values: Desired Count: {original_values['desired_count']}")
                                # Scale out ECS service by updating desired count
                                update_ecs_service_desired_count(cluster_name, service_name, original_values['desired_count'])
                                print(f"Scaled out ECS service {service_name} in cluster {cluster_name} to desired count: {original_values['desired_count']}")
                            else:
                                print(f"Failed to retrieve original values for service {service_name} in cluster {cluster_name}")
                                continue

                        else:
                            print("Invalid ecs_scale value. Skipping.")
                            continue
                    else:
                        print(f"Failed to fetch details for service {service_name} in cluster {cluster_name}")
            else:
                print(f"No services found in the cluster '{cluster_name}'")
    else:
        print("No clusters found.")
