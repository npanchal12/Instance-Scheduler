output "lambda_function_start_stop_rds_name" {
  description = "Lambda Function ARN to stop and start RDS"
  value       = module.lambda_function_start_stop_rds.lambda_function_name
}

output "lambda_function_start_stop_rds_arn" {
  description = "Lambda Function ARN to stop and start RDS"
  value       = module.lambda_function_start_stop_rds.lambda_function_arn
}

output "lambda_function_start_stop_non_asg_ec2_name" {
  description = "Lambda Function Name to stop and start Non-ASG Ec2"
  value       = module.lambda_function_start_stop_non_asg_ec2.lambda_function_name
}

output "lambda_function_start_stop_non_asg_ec2_arn" {
  description = "Lambda Function ARN to stop and start Non-ASG Ec2"
  value       = module.lambda_function_start_stop_non_asg_ec2.lambda_function_arn
}
