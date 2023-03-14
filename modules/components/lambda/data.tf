data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "instance_scheduler_policy" {

  statement {
    sid = "allowresourcestopstart"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstances",
      "ec2:StartInstances",
      "ec2:DescribeTags",
      "logs:*",
      "ec2:DescribeInstanceTypes",
      "ec2:StopInstances",
      "ec2:DescribeInstanceStatus",
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:StartDBCluster",
      "rds:StopDBCluster",
      "rds:ListTagsForResource",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}
