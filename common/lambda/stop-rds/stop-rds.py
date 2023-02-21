# import boto3
# import botocore

# rds = boto3.client('rds', region_name='ap-southeast-1')


# def lambda_handler(event, context):
#         # get all mysql db instances
#     rds_mysql = rds.describe_db_instances(Filters=[
#         {
#             'Name': 'engine',
#             'Values': ['mysql']
            
#         }
#         ])
#     for db in rds_mysql['DBInstances']:
#         # stop all rds instances
        
#         try:
#             rds.stop_db_instance(DBInstanceIdentifier=db['DBInstanceIdentifier'])
#         except botocore.exceptions.ClientError as err:
#             print(err)
#     # get all aurora db clusters
#     rds_aurora = rds.describe_db_clusters()
#         #stop all aurora cluster
#     for aurora_cluster in rds_aurora['DBClusters']:
#         try:
#             rds.stop_db_cluster(DBClusterIdentifier=aurora_cluster['DBClusterIdentifier'])
#         except botocore.exceptions.ClientError as err:
#             print(err)

import boto3
from botocore.exceptions import ClientError

# Define filter parameters for RDS clusters and instances
cluster_filter = [{'Name': 'tag:env', 'Values': ['prd'], 'Operator': 'NOT_IN'}]
instance_filter = [{'Name': 'tag:env', 'Values': ['prd'], 'Operator': 'NOT_IN'}]

# Create an RDS client
client = boto3.client('rds', region_name='ap-southeast-1')

# Stop RDS instances that do not match the filter
try:
    instances = client.describe_db_instances(Filters=instance_filter)
    for instance in instances['DBInstances']:
        instance_id = instance['DBInstanceIdentifier']
        status = instance['DBInstanceStatus']
        if status == 'available':
            client.stop_db_instance(DBInstanceIdentifier=instance_id)
            print(f'Successfully stopped RDS instance: {instance_id}')
        else:
            print(f'RDS instance {instance_id} already stopped')
except ClientError as e:
    print(f'Error stopping RDS instances: {e}')

# Stop RDS clusters that do not match the filter
try:
    clusters = client.describe_db_clusters(Filters=cluster_filter)
    for cluster in clusters['DBClusters']:
        cluster_id = cluster['DBClusterIdentifier']
        status = cluster['Status']
        if status == 'available':
            client.stop_db_cluster(DBClusterIdentifier=cluster_id)
            print(f'Successfully stopped RDS cluster: {cluster_id}')
        else:
            print(f'RDS cluster {cluster_id} already stopped')
except ClientError as e:
    print(f'Error stopping RDS clusters: {e}')
