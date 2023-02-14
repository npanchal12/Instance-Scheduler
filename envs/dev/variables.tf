#######################
# General settings
#######################
variable "standard_tags" {
  description = "Standard tags. If value is not applicable leave as empty or null."
  type = object({
    env : string
    app_tier : string
    appteam : string
    cost_centre : string
    product : string
    biz_dept : string
  })

  validation {
    condition     = can(regex("^dev$|^qa$|^uat$|^prd$", var.standard_tags.env))
    error_message = "Err: invalid env, must be one of dev|qa|uat|prd."
  }

  validation {
    condition     = can(regex("^[1-3]", var.standard_tags.app_tier))
    error_message = "Err: invalid app tier, must be one 1|2|3."
  }

  validation {
    condition     = can(regex("\\d{4}", var.standard_tags.cost_centre))
    error_message = "Err: invalid cost-centre, must be 4 digits."
  }
}

variable "map_migrated" {
  description = "Map-migrated discount code"
  type        = string
  default     = "d-server-00fyc0pr7gc8hv"
}

variable "aws_region" {
  description = "Region used to deploy resources"
  type        = string
  default     = "ap-southeast-1"
}
