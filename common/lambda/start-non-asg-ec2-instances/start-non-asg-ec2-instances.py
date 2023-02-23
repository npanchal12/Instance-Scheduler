import json
import boto3
ec2 = boto3.resource('ec2', region_name= 'ap-southeast-1')
def lambda_handler(event, context):
    instances = ec2.instances.filter(Filters=[
        {
             'Name': 'instance-state-name',
             'Values': ['stopped']
        },
        {
              'Name': 'tag:Name',
              'Values': ['non-asg-*','Non-asg-*']
        },
     ])
    
    instances.start()
    ids = ", ".join([instance.id for instance in instances])
    print(f"Instance IDs started: {ids}")
    return "success"
