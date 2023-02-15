################################################################################
# IAM Policy and IAM Role
################################################################################
module "iam_policy_instance_maintenance" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.13.0"

  name = "${var.standard_tags.product}-policy"
  # path        = "/"
  description = "IAM Policy to stop and start Non-asg ec2 and rds resources"

  policy = data.aws_iam_policy_document.instance_scheduler_policy.json
}

# module "instance_scheduler_role" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
#   version = "~> 4.13.0"

#   trusted_role_services = ["lambda.amazonaws.com",
#   "scheduler.amazonaws.com"]
#   create_role             = true
#   create_instance_profile = false
#   role_requires_mfa       = false
#   role_name               = "${var.standard_tags.product}-role"
# }

resource "aws_iam_role_policy_attachment" "instance_scheduler_role_attachment" {
  role       = module.lambda_function_stop_ec2.lambda_role_name
  policy_arn = module.iam_policy_instance_maintenance.arn
}

module "lambda_function_stop_ec2" {
  # source = "../../modules/components/lambda"
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name = "lambda-stop-non-asg-ec2-instances"
  description   = "lambda function to stop non asg ec2 instances"
  handler       = "ambda-stop-non-asg-ec2-instances.lambda_handler"
  runtime       = "python3.9"
  create_package = false


  # source_path = "../../common/lambda/stop-non-asg-ec2-instances"
  local_existing_package = "${path.module}/../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
}

# module "lambda_function_start_ec2" {
#   source  = "terraform-aws-modules/lambda/aws"
#   version = "~> 4.10.1"

#   function_name = "start_non_asg_ec2_instances"
#   description   = "lambda function to start non asg ec2 instances"
#   handler       = "index.lambda_handler"
#   runtime       = "python3.9"
#   role_name     = module.instance_scheduler_role.iam_role_name

#   source_path = "../../src/start-non-asg-ec2-instances"

#   tags = {
#     Name = "start_non_asg_ec2_instances"
#   }
# }

# module "lambda_function_stop_rds" {
#   source  = "terraform-aws-modules/lambda/aws"
#   version = "~> 4.10.1"

#   function_name = "lambda-stop-rds"
#   description   = "Lambda to trigger stop rds instance and cluster"
#   handler       = "index.lambda_handler"
#   role_name     = module.instance_scheduler_role.iam_role_name
#   runtime       = "python3.9"

#   source_path = "../../src/stop-rds/"

#   tags = {
#     Name = "lambda-stop-rds"
#   }
# }

# module "lambda_function_start_rds" {
#   source  = "terraform-aws-modules/lambda/aws"
#   version = "~> 4.10.1"

#   function_name = "lambda-start-rds"
#   description   = "Lambda to trigger start rds instance and cluster"
#   handler       = "index.lambda_handler"
#   role_name     = module.instance_scheduler_role.iam_role_name
#   runtime = "python3.9"

#   source_path = "../../src/start-rds/"

#   tags = {
#     Name = "lambda-start-rds"
#   }
# }
