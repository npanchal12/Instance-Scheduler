# import boto3
# import logging

# # Define filter parameters for RDS clusters based on environment tag
# environment_filter = [{'Name': 'tag:sph:env', 'Values': ['dev']}]

# # Create an RDS client
# client = boto3.client('rds')

# # Create a logger object
# logger = logging.getLogger()
# logger.setLevel(logging.INFO)

# def stop_clusters(environment_filter):
#     paginator = client.get_paginator('describe_db_clusters')
#     for clusters in paginator.paginate(Filters=environment_filter):
#         for cluster in clusters['DBClusters']:
#             cluster_id = cluster['DBClusterIdentifier']
#             status = cluster['Status']
#             if status == 'available':
#                 try:
#                     client.stop_db_cluster(DBClusterIdentifier=cluster_id)
#                     logger.info(f'Successfully stopped RDS cluster: {cluster_id}')
#                 except Exception as e:
#                     logger.error(f'Error stopping RDS cluster {cluster_id}: {e}')
#             else:
#                 logger.info(f'RDS cluster {cluster_id} already stopped or does not match filter')

# def lambda_handler(event, context):
#     try:
#         stop_clusters(environment_filter)
#     except Exception as e:
#         logger.error(f'Error stopping RDS clusters: {e}')

