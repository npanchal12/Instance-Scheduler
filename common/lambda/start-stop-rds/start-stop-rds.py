import boto3

def lambda_handler(event, context):
    # Extract the desired status from the input event
    desired_status = event['status']

    # Create an RDS client
    rds_client = boto3.client('rds')

    # Get information about all RDS clusters
    response = rds_client.describe_db_clusters()

    # Iterate through the clusters and check their status
    for cluster in response['DBClusters']:
        cluster_name = cluster['DBClusterIdentifier']
        cluster_status = cluster['Status']

        # If the cluster is in the desired status, stop or start it
        if cluster_status == desired_status:
            response = rds_client.stop_db_cluster(
                DBClusterIdentifier=cluster_name
            )
            print(f"Stopped cluster {cluster_name}")
        elif cluster_status != desired_status:
            response = rds_client.start_db_cluster(
                DBClusterIdentifier=cluster_name
            )
            print(f"Started cluster {cluster_name}")
        else:
            print(f"Skipping cluster {cluster_name} with status {cluster_status}")

    # Return a success message
    return {
        'statusCode': 200,
        'body': f"All RDS clusters in {desired_status} status have been stopped or started."
    }
