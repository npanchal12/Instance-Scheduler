terraform {
  required_version = ">= 1.3.0"

  required_providers {
    # tflint-ignore: terraform_unused_required_providers
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.45.0"
    }
  }
}
