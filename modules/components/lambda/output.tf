output "lambda_function_stop_ec2_name" {
  description = "Lambda Function Name"
  value       = module.lambda_function_stop_ec2.lambda_function_name
}

output "lambda_function_stop_ec2_arn" {
  description = "Lambda Function Name"
  value       = module.lambda_function_stop_ec2.lambda_function_arn
}

output "lambda_function_start_ec2_name" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_ec2.lambda_function_name
}

output "lambda_function_start_ec2_arn" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_ec2.lambda_function_arn
}

# output "lambda_function_stop_rds_name" {
#   description = "Lambda Function Name"
#   value       = module.lambda_function_stop_rds.lambda_function_name
# }

# output "lambda_function_stop_rds_arn" {
#   description = "Lambda Function Name"
#   value       = module.lambda_function_stop_rds.lambda_function_arn
# }

# output "lambda_function_start_rds_name" {
#   description = "Lambda Function Name"
#   value       = module.lambda_function_start_rds.lambda_function_name
# }

# output "lambda_function_start_rds_arn" {
#   description = "Lambda Function Name"
#   value       = module.lambda_function_start_rds.lambda_function_arn
# }

output "lambda_function_start_stop_rds_name" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_stop_rds.lambda_function_name
}

output "lambda_function_start_stop_rds_arn" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_stop_rds.lambda_function_arn
}
