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

output "lambda_function_udpate_scale_asg_name" {
  description = "Lambda Function Name to Scale ASG Ec2"
  value       = module.lambda_function_udpate_scale_asg.lambda_function_name
}

output "lambda_function_udpate_scale_asg_arn" {
  description = "Lambda Function ARN to Scale ASG Ec2"
  value       = module.lambda_function_udpate_scale_asg.lambda_function_arn
}

output "lambda_function_udpate_ecs_scale_asg_name" {
  description = "Lambda Function Name to Scale ECS Tasks"
  value       = module.lambda_function_udpate_ecs_scale_asg.lambda_function_name
}

output "lambda_function_udpate_ecs_scale_asg_arn" {
  description = "Lambda Function ARN to Scale ECS Tasks"
  value       = module.lambda_function_udpate_ecs_scale_asg.lambda_function_arn
}
