output "lambda_function_stop_ec2" {
  description = "Lambda Function Name"
  value       = module.lambda_function_stop_ec2.lambda_function_name
}

output "lambda_function_start_ec2" {
  description = "Lambda Function Name"
  value       = module.lambda_function_start_ec2.lambda_function_name
}
