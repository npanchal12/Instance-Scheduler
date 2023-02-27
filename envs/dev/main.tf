
module "scheduler" {
  source = "../../modules/components/scheduler"

  lambda_function_start_stop_rds_arn          = module.lambda_function.lambda_function_start_stop_rds_arn
  lambda_function_start_stop_rds_name         = module.lambda_function.lambda_function_start_stop_rds_name
  lambda_function_start_stop_non_asg_ec2_arn  = module.lambda_function.lambda_function_start_stop_non_asg_ec2_arn
  lambda_function_start_stop_non_asg_ec2_name = module.lambda_function.lambda_function_start_stop_non_asg_ec2_name
}

module "lambda_function" {
  source = "../../modules/components/lambda"

  start_stop_rds_code         = data.archive_file.start_stop_rds_zip_file.output_path
  start_stop_non_asg_ec2_code = data.archive_file.start_stop_non-asg-ec2_zip_file.output_path
}
