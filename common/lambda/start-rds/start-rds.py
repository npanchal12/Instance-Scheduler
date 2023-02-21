import boto3
import botocore

rds = boto3.client('rds', region_name='ap-southeast-1')


def lambda_handler(event, context):
        # get all mysql db instances
    rds_mysql = rds.describe_db_instances(Filters=[
        {
            'Name': 'engine',
            'Values': ['mysql']
            
        }
        ])
    for db in rds_mysql['DBInstances']:
        # start all rds instances
        
        try:
            rds.start_db_instance(DBInstanceIdentifier=db['DBInstanceIdentifier'])
        except botocore.exceptions.ClientError as err:
            print(err)
    # get all aurora db clusters
    rds_aurora = rds.describe_db_clusters()
        #start all aurora cluster
    for aurora_cluster in rds_aurora['DBClusters']:
        try:
            rds.start_db_cluster(DBClusterIdentifier=aurora_cluster['DBClusterIdentifier'])
        except botocore.exceptions.ClientError as err:
            print(err)
