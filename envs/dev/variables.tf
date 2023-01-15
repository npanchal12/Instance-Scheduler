variable "aws_region" {
  description = "Region used to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "name" {
  description = "Name of the application"
  type        = string
  default     = "instance-scheduler"
}
