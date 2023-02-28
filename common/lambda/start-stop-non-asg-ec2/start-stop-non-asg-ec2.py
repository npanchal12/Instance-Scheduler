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

    # Loop through instances and start or stop as necessary
    for instance in instances:
        id = instance.id

        # Start or stop instance based on filtered status
        if filtered_status == 'stopped':
            instances.start()
            ids = ", ".join([instance.id for instance in instances])
            print(f"Instance IDs started: {ids}")
        elif filtered_status == 'running':
            instances.stop()
            ids = ", ".join([instance.id for instance in instances])
            print(f"Instance IDs stopped: {ids}")

    return {
        'statusCode': 200,
        'body': json.dumps('All instances have been started or stopped as necessary.')
    }
