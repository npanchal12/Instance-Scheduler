resource "aws_scheduler_schedule" "stop_ec2" {
  name = "stop-non-asg-ec2-instances"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(30 12 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_stop_ec2_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}

resource "aws_scheduler_schedule" "start_ec2" {
  name = "start-non-asg-ec2-instances"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(05 12 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_start_ec2_arn
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
    arn      = var.lambda_function_stop_rds_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}

resource "aws_scheduler_schedule" "start_rds" {
  name = "start-non-prod-rds"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(04 13 * * ? *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_start_rds_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
  }
}# 
