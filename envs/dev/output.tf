output "lambda_function_stop_ec2" {
  description = "Lambda Function Name"
  value       = module.lambda_function_stop_ec2.lambda_function_name
}

output "lambda_function_stop_ec2_arn" {
  description = "Lambda Function Name"
  value       = module.lambda_function_stop_ec2.lambda_function_arn
}

output "lambda_function_start_ec2" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_ec2.lambda_function_name
}

output "lambda_function_start_ec2_arn" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_ec2.lambda_function_arn
}

output "instance_scheduler_role_arn" {
  description = "IAM role arn"
  value       = module.instance_scheduler_role.iam_role_arn
}
