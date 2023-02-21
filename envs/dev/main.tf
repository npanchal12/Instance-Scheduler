
module "scheduler" {
  source = "../../modules/components/scheduler"

  # instance_scheduler_role_arn = module.instance_scheduler_role.iam_role_arn
  lambda_function_stop_ec2_arn   = module.lambda_function.lambda_function_stop_ec2_arn
  lambda_function_start_ec2_arn  = module.lambda_function.lambda_function_start_ec2_arn
  lambda_function_stop_rds_arn   = module.lambda_function.lambda_function_stop_rds_arn
  lambda_function_start_rds_arn  = module.lambda_function.lambda_function_start_rds_arn
  lambda_function_stop_ec2_name  = module.lambda_function.lambda_function_stop_ec2_name
  lambda_function_start_ec2_name = module.lambda_function.lambda_function_start_ec2_name
  lambda_function_stop_rds_name  = module.lambda_function.lambda_function_stop_rds_name
  lambda_function_start_rds_name = module.lambda_function.lambda_function_start_rds_name
}

module "lambda_function" {
  source         = "../../modules/components/lambda"
  
  stop_ec2_code  = "${path.module}/../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
  start_ec2_code = "${path.module}/../../common/build/start-non-asg-ec2-instances/start-non-asg-ec2-instances.zip"
  stop_rds_code  = "${path.module}/../../common/build/stop-rds/stop-rds.zip"
  start_rds_code = "${path.module}/../../common/build/start-rds/start-rds.zip"
}
