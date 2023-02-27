import json
import boto3

def lambda_handler(event, context):
    # Get JSON input from event
    payload = json.loads(event['body'])
    filtered_status = payload['status']

    # Get EC2 resource
    ec2 = boto3.resource('ec2')

    # Get all instances matching the name filter
    instances = ec2.instances.filter(
        Filters=[
            {
                'Name': 'tag:Name',
                'Values':  ['non-asg-*','Non-asg-*']
            },
            {
                'Name': 'instance-state-name',
                'Values': [
                    filtered_status
                ]
            },
        ]
    )

    # Initialize lists for successful and failed instances
    success = []
    failure = []

    # Loop through instances and start or stop as necessary
    for instance in instances:
        instance_id = instance.id
        current_status = instance.state['Name']

        # Start or stop instance based on filtered status
        if current_status == filtered_status:
            try:
                if filtered_status == 'stopped':
                    instance.start()
                    success.append(instance)
                elif filtered_status == 'running':
                    instance.stop()
                    success.append(instance)
            except Exception as e:
                failure.append(instance)
                print(f"Failed to {filtered_status} instance {instance.id}: {e}")

    # Print details of successful instances
    if success:
        ids = ", ".join([instance.id for instance in success])
        print(f"Instance IDs {ids} {filtered_status}: successful")

    # Print details of failed instances
    if failure:
        ids = ", ".join([instance.id for instance in failure])
        print(f"Failed to {filtered_status} instances: {[instance.id for instance in failure]}")

    return {
        'statusCode': 200,
        'body': json.dumps('All instances have been started or stopped as necessary.')
    }
