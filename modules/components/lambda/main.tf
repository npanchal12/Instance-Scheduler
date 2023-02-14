module "lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name = var.function_name
  # description   = "lambda function to stop non asg ec2 instances"
  handler       = var.handler
  runtime       = var.runtime
  role_name     = var.role_name
  local_existing_package = var.local_existing_package

  tags = {
    Name = var.function_name
  }
}
