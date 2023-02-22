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
              'Values': ['Non-asg-*']
        },
     ])
    for instance in instances:
         id= instance.id
         ec2.instances.filter(InstanceIds=[id]).start()
         print("Instance ID started="+str(id))
    return "success"
