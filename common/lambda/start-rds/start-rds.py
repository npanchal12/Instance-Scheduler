import boto3
from botocore.exceptions import ClientError

# Define filter parameters for RDS clusters based on environment tag
environment_filter = [{'Name': 'tag:sph:env', 'Values': ['dev']}]

# Create an RDS client
client = boto3.client('rds')

def start_rds_clusters(event, context):
    try:
        # Get all RDS clusters
        response = client.describe_db_clusters()
        for cluster in response['DBClusters']:
            cluster_id = cluster['DBClusterIdentifier']
            status = cluster['Status']
            if status == 'stopped':
                # Check if the RDS cluster matches the environment filter
                if all(filter not in cluster['TagList'] for filter in environment_filter):
                    # RDS cluster does not match the environment filter, start it
                    client.start_db_cluster(DBClusterIdentifier=cluster_id)
                    print(f'Successfully started RDS cluster: {cluster_id}')
                else:
                    # RDS cluster matches the environment filter
                    print(f'Skipping RDS cluster: {cluster_id} as it matches the environment filter')
            else:
                # RDS cluster is already started
                print(f'RDS cluster {cluster_id} is already started')
    except ClientError as e:
        print(f'Error starting RDS clusters: {e}')

# Lambda function handler
def lambda_handler(event, context):
    start_rds_clusters(event, context)
