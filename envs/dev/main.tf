
module "scheduler" {
  source = "../../modules/components/scheduler"

  lambda_function_start_stop_rds_arn          = module.lambda_function.lambda_function_start_stop_rds_arn
  lambda_function_start_stop_rds_name         = module.lambda_function.lambda_function_start_stop_rds_name
  lambda_function_start_stop_non_asg_ec2_arn  = module.lambda_function.lambda_function_start_stop_non_asg_ec2_arn
  lambda_function_start_stop_non_asg_ec2_name = module.lambda_function.lambda_function_start_stop_non_asg_ec2_name
}

module "lambda_function" {
  source = "../../modules/components/lambda"

  start_stop_rds_code         = "${path.module}/../../common/build/start-stop-rds/start-stop-rds.zip"
  start_stop_non_asg_ec2_code = "${path.module}/../../common/build/start-stop-non-asg-ec2/start-stop-non-asg-ec2.zip"
}
