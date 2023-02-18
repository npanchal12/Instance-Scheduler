module "lambda_function_stop_ec2" {
  # source = "../../modules/components/lambda"
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-stop-non-asg-ec2-instances"
  description    = "lambda function to stop non asg ec2 instances"
  handler        = "stop-non-asg-ec2-instances.lambda_handler"
  runtime        = "python3.9"
  create_package = false


  # source_path = "../../common/lambda/stop-non-asg-ec2-instances"
  local_existing_package = "${path.module}/../../common/build/stop-non-asg-ec2-instances/stop-non-asg-ec2-instances.zip"
}

module "lambda_function_start_ec2" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-start_non_asg_ec2_instances"
  description    = "lambda function to start non asg ec2 instances"
  handler        = "start-non-asg-ec2-instances.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = "${path.module}/../../common/build/start-non-asg-ec2-instances/start-non-asg-ec2-instances.zip"
}

module "lambda_function_stop_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-stop-rds"
  description    = "Lambda to trigger stop rds instance and cluster"
  handler        = "stop-rds.lambda_handler"
  runtime        = "python3.9"
  create_package = false

  local_existing_package = "${path.module}/../../common/build/stop-rds/stop-rds.zip"

}

module "lambda_function_start_rds" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.10.1"

  function_name  = "lambda-start-rds"
  description    = "Lambda to trigger start rds instance and cluster"
  handler        = "start-rds.lambda_handler"
  runtime        = "python3.9"
  source_path    = "../../src/start-rds/"
  create_package = false

  local_existing_package = "${path.module}/../../common/build/start-rds/start-rds.zip"

}

# module "eventbridge" {
#   source  = "terraform-aws-modules/eventbridge/aws"
#   version = "1.17.2"

#   create_bus = false

#   rules = {
#     crons = {
#       description         = "Trigger for a Lambda"
#       schedule_expression = "rate(5 minutes)"
#     }
#   }

#   targets = {
#     crons = [
#       {
#         name  = "lambda-loves-cron"
#         arn   = module.lambda_function_stop_ec2.lambda_function_arn
#         input = jsonencode({ "job" : "cron-by-rate" })
#       }
#     ]
#   }
# }

# module "eventbridge" {
#   source = "../../modules/components/scheduler"
#   instance_scheduler_role = var.instance_scheduler_role
#   lambda_function_arn = var.lambda_function_stop_ec2_arn
# }

resource "aws_scheduler_schedule" "example" {
  name = "stop-non-asg-ec2-instances"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(15 11 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = module.lambda_function_stop_ec2.lambda_function_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}

resource "aws_scheduler_schedule" "start_ec2" {
  name = "start-non-asg-ec2-instances"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(05 11 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = module.lambda_function_start_ec2.lambda_function_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}

resource "aws_scheduler_schedule" "stop_rds" {
  name = "stop-non-prod-rds"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(49 11 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = module.lambda_function_stop_rds.lambda_function_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}

resource "aws_scheduler_schedule" "start_rds" {
  name = "start-non-prod-rds"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(28 11 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = module.lambda_function_start_rds.lambda_function_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}
