########################
#  Application Specific
########################
variable "start_stop_rds_code" {
  description = "Path for the start and stop rds cluster and instance code"
  type        = string
}

variable "start_stop_non_asg_ec2_code" {
  description = "Path for the start and stop rds cluster and instance code"
  type        = string
}

variable "update_asg_scale_code" {
  description = "Path for the update asg scale instance code"
  type        = string
}

variable "update_ecs_asg_scale_code" {
  description = "Path for the update asg scale ecs tasks code"
  type        = string
}
