module "lambda_function_stop_ec2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-stop-non-asg-ec2-instances"
  description    = "lambda function to stop non asg ec2 instances"
  handler        = "stop-non-asg-ec2-instances.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = "${path.module}/../../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
}

module "lambda_function_start_ec2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-start_non-asg-ec2_instances"
  description    = "lambda function to start non asg ec2 instances"
  handler        = "start-non-asg-ec2-instances.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = "${path.module}/../../../common/build/start-non-asg-ec2-instances/start-non-asg-ec2-instances.zip"
}

module "lambda_function_stop_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-stop-rds"
  description    = "Lambda to trigger stop rds instance and cluster"
  handler        = "stop-rds.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = "${path.module}/../../../common/build/stop-rds/stop-rds.zip"

}

module "lambda_function_start_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-start-rds"
  description    = "Lambda to trigger start rds instance and cluster"
  handler        = "start-rds.lambda_handler"
  runtime        = "python3.9"
  source_path    = "../../src/start-rds/"
  create_package = false

  local_existing_package = "${path.module}/../../../common/build/start-rds/start-rds.zip"
}
