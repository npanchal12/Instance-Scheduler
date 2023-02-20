########################
#  Application Specific
########################

variable "app_name" {
  description = "Name of the application. This will be used as prefix for all the resources"
  type        = string
  default     = "instance-scheduler"
}

variable "env" {
  description = "Environment. This will be used as stage in API GW"
  type        = string
  default     = "dev"
}

# variable "local_existing_package" {
#   description = "Path for Non-ASG EC2 Instance code"
#   type        = string
# }

# variable "description" {
#   description = "Description for Lambda functions"
#   type        = string
# }

# variable "function_name" {
#   description = "Lambda function name"
#   type        = string
# }

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.lambda_handler"
}

variable "runtime" {
  description = "Runtime details"
  type        = string
  default     = "python3.9"
}

# variable "role_name" {
#   description = "IAM role to invoke lambda, stop and start aws resources"
#   type        = string
# }
