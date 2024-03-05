terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }

  cloud {
    organization = "nimesh-org" # Replace the organization name with your own

    workspaces {
      # Fixed name
      name = "instance-scheduler-workspace" # Replace workspace name with your own
    }
  }
}
