data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "instance_scheduler_policy" {
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_356
  statement {
    sid = "allowresourcestopstart"
    actions = [
      "autoscaling:UpdateAutoScalingGroup",
      "autoscaling:DescribeAutoScalingGroups",
      "application-autoscaling:RegisterScalableTarget",
      "application-autoscaling:DescribeScalableTargets",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeInstanceStatus",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ecs:UpdateService",
      "ecs:ListServices",
      "ecs:ListClusters",
      "ecs:DescribeServices",
      "ecs:ListTagsForResource",
      "logs:*",
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:ListTagsForResource",
      "rds:StartDBCluster",
      "rds:StopDBCluster",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }

  statement {
    sid = "limiteddynmodbaccess"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:table/asg_counts",
      "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:table/ecs_task_counts"
    ]
  }
}
