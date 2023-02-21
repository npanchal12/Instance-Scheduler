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
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }
}

data "archive_file" "stop_ec2_zip_file" {

  output_path = "${path.module}/../../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
  source_dir  = "${path.module}/../../../common/lambda/stop-non-asg-ec2-instances"
  type        = "zip"
}

data "archive_file" "start_ec2_zip_file" {

  output_path = "${path.module}/../../../common/build/start-non-asg-ec2-instances/start-non-asg-ec2-instances.zip"
  source_dir  = "${path.module}/../../../common/lambda/start-non-asg-ec2-instances"
  type        = "zip"
}

data "archive_file" "stop_rds_zip_file" {

  output_path = "${path.module}/../../../common/build/stop-rds/stop-rds.zip"
  source_dir  = "${path.module}/../../../common/lambda/stop-rds"
  type        = "zip"
}

data "archive_file" "start_rds_zip_file" {

  output_path = "${path.module}/../../../common/build/start-rds/start-rds.zip"
  source_dir  = "${path.module}/../../../common/lambda/start-rds"
  type        = "zip"
}
