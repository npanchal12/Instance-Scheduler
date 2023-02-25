variable "app_name" {
  description = "Name of the application. This will be used as prefix for all the resources"
  type        = string
  default     = "instance-scheduler"
}

# variable "lambda_function_stop_ec2_arn" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_start_ec2_arn" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_stop_rds_arn" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_start_rds_arn" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_start_rds_arn" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_stop_ec2_name" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_start_ec2_name" {
#   description = "IAM Role"
#   type        = string
# }

# variable "lambda_function_stop_rds_name" {
#   description = "IAM Role"
#   type        = string
# }

variable "lambda_function_start_stop_rds_name" {
  description = "Lambda Function name to Stop and Start RDS"
  type        = string
}

variable "lambda_function_start_stop_rds_arn" {
  description = "Lambda Function Arn to Stop and Start RDS"
  type        = string
}

variable "lambda_function_start_stop_non_asg_ec2_name" {
  description = "Lambda Function name to Stop and Start Non-ASG EC2 Instances"
  type        = string
}

variable "lambda_function_start_stop_non_asg_ec2_arn" {
  description = "Lambda Function ARN to Stop and Start Non-ASG EC2 Instances"
  type        = string
}
