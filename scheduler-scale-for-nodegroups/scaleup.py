import os
import boto3

def lambda_handler(event, context):

    eks = boto3.client("eks")

    region_name = os.environ.get("region_name")
    cluster_name = os.environ.get("cluster_name")
    nodegroup_names = ["node-group-name"]
    new_minSize = 3
    new_desiredSize = 3
    new_maxSize = 5

    for nodegroup_name in nodegroup_names:
        response = eks.update_nodegroup_config(
            clusterName=cluster_name,
            nodegroupName=nodegroup_name,
            scalingConfig={
                "minSize": new_minSize,
                "desiredSize": new_desiredSize,
                "maxSize": new_maxSize
            }
        )

        print(response)