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
