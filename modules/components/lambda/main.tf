#tfsec:ignore:aws-lambda-enable-tracing
module "lambda_function_start_stop_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name                     = "lambda-start-stop-rds"
  description                       = "Lambda to trigger stop rds instances and clusters"
  handler                           = "start-stop-rds.lambda_handler"
  runtime                           = "python3.9"
  create_package                    = false
  architectures                     = ["arm64"]
  timeout                           = 600 # in seconds
  cloudwatch_logs_retention_in_days = 60  # in days

  local_existing_package = var.start_stop_rds_code
}

#tfsec:ignore:aws-lambda-enable-tracing
module "lambda_function_start_stop_non_asg_ec2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name                     = "lambda-start-stop-non-asg-ec2"
  description                       = "Lambda to trigger stop non-asg ec2 instances"
  handler                           = "start-stop-non-asg-ec2.lambda_handler"
  runtime                           = "python3.9"
  create_package                    = false
  architectures                     = ["arm64"]
  timeout                           = 600 # in seconds
  cloudwatch_logs_retention_in_days = 60  # in days

  local_existing_package = var.start_stop_non_asg_ec2_code
}

#tfsec:ignore:aws-lambda-enable-tracing
########### Lambda for Update Auto Scaling
module "lambda_function_udpate_scale_asg" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name                     = "lambda-update-asg_scale"
  description                       = "Lambda to trigger update asg scaling for ec2 instances"
  handler                           = "update-asg-scale-ec2.lambda_handler"
  runtime                           = "python3.9"
  create_package                    = false
  architectures                     = ["arm64"]
  timeout                           = 600 # 10mins
  cloudwatch_logs_retention_in_days = 60  # in days

  local_existing_package = var.update_asg_scale_code
}

#tfsec:ignore:aws-lambda-enable-tracing
########### Lambda for Update ECS Tasks Auto Scaling
module "lambda_function_udpate_ecs_scale_asg" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name                     = "lambda-update-ecs-asg_scale"
  description                       = "Lambda to trigger update asg scaling for ecs tasks"
  handler                           = "update-asg-scale-ecs.lambda_handler"
  runtime                           = "python3.9"
  create_package                    = false
  architectures                     = ["arm64"]
  timeout                           = 900 # 15mins
  cloudwatch_logs_retention_in_days = 60  # 2months

  local_existing_package = var.update_ecs_asg_scale_code
}
