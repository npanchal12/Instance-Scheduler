variable "app_name" {
  description = "Name of the application. This will be used as prefix for all the resources"
  type        = string
  default     = "instance-scheduler"
}

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

variable "startup_hour" {
  description = "Hour for starting up resources in UTC +8. RDS startup will be hour - 20 mins"
  type        = number
  default     = 8

  validation {
    condition     = var.startup_hour >= 5 && var.startup_hour <= 17
    error_message = "Startup hour must 5 <= hour <= 17"
  }
}

variable "shutdown_hour" {
  description = "Hour for shutting down resources in UTC +8."
  type        = number
  default     = 20

  validation {
    condition     = var.shutdown_hour >= 18 || var.shutdown_hour <= 4
    error_message = "Shutdown hour must be >= 18 or <= 4"
  }
}

########## ASG Scale #################

variable "lambda_function_update_scale_asg_ec2_name" {
  description = "Lambda Function Name to Update scale for EC2 Instances"
  type        = string
}

variable "lambda_function_update_scale_asg_ec2_arn" {
  description = "Lambda Function ARN to Update scale for EC2 Instances"
  type        = string
}

variable "lambda_function_update_scale_asg_ecs_name" {
  description = "Lambda Function Name to Update scale for ECS Tasks"
  type        = string
}

variable "lambda_function_update_scale_asg_ecs_arn" {
  description = "Lambda Function ARN to Update scale for ECS Tasks"
  type        = string
}
