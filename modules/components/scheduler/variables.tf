variable "app_name" {
  description = "Name of the application. This will be used as prefix for all the resources"
  type        = string
  default     = "instance-scheduler"
}

variable "lambda_function_stop_ec2_arn" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_start_ec2_arn" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_stop_rds_arn" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_start_rds_arn" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_stop_ec2_name" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_start_ec2_name" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_stop_rds_name" {
  description = "IAM Role"
  type        = string
}

variable "lambda_function_start_rds_name" {
  description = "IAM Role"
  type        = string
}
