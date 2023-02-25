module "lambda_function_start_stop_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-start-stop-rds"
  description    = "Lambda to trigger stop rds instances and clusters"
  handler        = "start-stop-rds.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = var.start_stop_rds_code

}

module "lambda_function_start_stop_non_asg_ec2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-start-stop-non-asg-ec2"
  description    = "Lambda to trigger stop non-asg ec2 instances"
  handler        = "start-stop-non-asg-ec2.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = var.start_stop_non_asg_ec2_code

}
