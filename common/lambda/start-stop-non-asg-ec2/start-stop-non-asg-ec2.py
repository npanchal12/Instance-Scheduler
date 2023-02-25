import json
import boto3

def lambda_handler(event, context):
    # Get JSON input from event
    input_data = json.loads(event['body'])

    # Get the desired status from input data
    desired_status = event['status']

    # Get EC2 resource
    ec2 = boto3.resource('ec2')

    # Get all instances matching the name filter
    instances = ec2.instances.filter(
        Filters=[
            {
                'Name': 'tag:Name',
                'Values':  [
                    input_data['name']
                ]
            }
        ]
    )
    
     # Check if there are instances matching the filter
    if len(list(instances)) == 0:
        return {
            'statusCode': 404,
            'body': json.dumps('No instances found matching the provided name filter.')
        }

    # Loop through instances and start or stop as necessary
    for instance in instances:
        instance_id = instance.id
        current_status = instance.state['Name']

        # Start or stop instance based on desired status
        if current_status != desired_status:
            if desired_status == 'running':
                instance.start()
            elif desired_status == 'stopped':
                instance.stop()

    return {
        'statusCode': 200,
        'body': json.dumps('All instances have been started or stopped as necessary.')
    }
