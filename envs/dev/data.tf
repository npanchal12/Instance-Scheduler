data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# data "aws_ssm_parameter" "db_subnet_group" {
#   name = "/aft/provisioned/vpc/database_subnet_group"
# }

# data "aws_subnet" "private_subnets_az1" {
#   vpc_id               = local.ssm_vpc.vpc_id
#   availability_zone_id = "apse1-az1"
#   tags = {
#     Name = "aft-app-ap-southeast-1a"
#   }
# }

# data "aws_ssm_parameters_by_path" "vpc" {
#   path      = local.ssm_aft_path
#   recursive = true
# }

# data "aws_ami" "amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn-ami-hvm-*-x86_64-gp2"]
#   }
# }

data "archive_file" "stop_non_asg_ec2_instances_code" {
  type        = "zip"
  source_file = "${path.module}/../../common/lambda/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.py"
  output_path = "${path.module}/../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
}

# data "archive_file" "start_asg_ec2_instances" {
#   type        = "zip"
#   source_file = "${path.module}/../../common/lambda/start-non-asg-ec2-instances/start-non-asg-ec2-instances.py"
#   output_path = "${path.module}/../../common/build/start-non-asg-ec2-instances/start-non-asg-ec2-instances.zip"
# }

# data "archive_file" "stop_rds" {
#   type        = "zip"
#   source_file = "${path.module}/../../common/lambda/stop-rds/stop-rds.py"
#   output_path = "${path.module}/../../common/build/stop-rds/stop-rds.zip"
# }

# data "archive_file" "start_rds" {
#   type        = "zip"
#   source_file = "${path.module}/../../common/lambda/start-rds/start-rds.py"
#   output_path = "${path.module}/../../common/build/start-rds/start-rds.zip"
# }

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
  statement {
    sid = "invokelambdafunction"
    actions = [
      "lambda:InvokeFunction"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:lambda-*:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:lambda-*"
    ]
  }
}
