import boto3
from botocore.exceptions import ClientError

# Define filter parameters for RDS clusters based on environment tag
environment_filter = [{'Name': 'tag:env', 'Values': ['prd']}]

# Create an RDS client
client = boto3.client('rds')

def lambda_handler(event, context):
    # Stop RDS clusters that do not match the environment filter
    try:
        clusters = client.describe_db_clusters()
        for cluster in clusters['DBClusters']:
            cluster_id = cluster['DBClusterIdentifier']
            status = cluster['Status']
            if status == 'available' and cluster['TagList'] != environment_filter:
                client.stop_db_cluster(DBClusterIdentifier=cluster_id)
                print(f'Successfully stopped RDS cluster: {cluster_id}')
            else:
                print(f'RDS cluster {cluster_id} already stopped or does not match filter')
    except ClientError as e:
        print(f'Error stopping RDS clusters: {e}')
