# module "scheduler" {
#   source = "../../modules/components/scheduler"

#   # instance_scheduler_role_arn = module.instance_scheduler_role.iam_role_arn
#   lambda_function_stop_ec2_arn   = module.lambda_function_stop_ec2.lambda_function_arn
#   lambda_function_start_ec2_arn  = module.lambda_function_start_ec2.lambda_function_arn
#   lambda_function_stop_rds_arn   = module.lambda_function_stop_rds.lambda_function_arn
#   lambda_function_start_rds_arn  = module.lambda_function_start_rds.lambda_function_arn
#   lambda_function_stop_ec2_name  = module.lambda_function_stop_ec2.lambda_function_name
#   lambda_function_start_ec2_name = module.lambda_function_start_ec2.lambda_function_name
#   lambda_function_stop_rds_name  = module.lambda_function_stop_rds.lambda_function_name
#   lambda_function_start_rds_name = module.lambda_function_start_rds.lambda_function_name
# }

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
  source  = "../../modules/components/lambda"
}
