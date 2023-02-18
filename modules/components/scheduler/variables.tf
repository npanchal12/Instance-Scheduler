# variable "instance_scheduler_role" {
#   description = "IAM Role"
#   type        = string

# }

# variable "lambda_function_arn" {
#   description = "IAM Role"
#   type        = string
# }

variable "instance_scheduler_role_arn" {
  description = "IAM Role ARN"
  type        = string
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
