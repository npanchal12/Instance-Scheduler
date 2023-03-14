
import boto3
import json

def lambda_handler(event, context):
    # Extract the filtered status from the input payload event
    payload = json.loads(event['body'])
    filtered_status = payload['status']

    # Create a connection using RDS client
    rds_client = boto3.client('rds')

    # Get information about all RDS clusters in the account
    response = rds_client.describe_db_clusters()

    # Iterate through the clusters and check their status
    for cluster in response['DBClusters']:
        cluster_name = cluster['DBClusterIdentifier']
        cluster_status = cluster['Status']

        # Check if the cluster should be skipped based on the sph:scheduler tag
        tags_response = rds_client.list_tags_for_resource(ResourceName=cluster['DBClusterArn'])
        for tag in tags_response['TagList']:
            if tag['Key'] == 'sph:scheduler' and tag['Value'] == 'true':
                print(f"Skipping cluster {cluster_name} due to sph:scheduler tag set to true")
                break
        else:
            # If the cluster is in the filtered status, stop or start it
            if cluster_status == 'available':
                response = rds_client.stop_db_cluster(DBClusterIdentifier=cluster_name)
                print(f"Stopped cluster {cluster_name}")
            elif cluster_status == 'stopped':
                response = rds_client.start_db_cluster(DBClusterIdentifier=cluster_name)
                print(f"Started cluster {cluster_name}")
            else:
                print(f"Skipping cluster {cluster_name} with status {cluster_status}")

    # Return a success message
    return {
        'statusCode': 200,
        'body': f"All RDS clusters in {filtered_status} status have been stopped or started."
    }
