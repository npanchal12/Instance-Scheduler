resource "aws_scheduler_schedule" "stop_ec2" {
  #checkov:skip=CKV_AWS_297\
  name = "stop-non-asg-ec2-instances"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.shutdown_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_start_stop_non_asg_ec2_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"status\": \"running\"}"
    })
  }
}

resource "aws_scheduler_schedule" "start_ec2" {
  #checkov:skip=CKV_AWS_297
  name = "start-non-asg-ec2-instances"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.startup_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_start_stop_non_asg_ec2_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"status\": \"stopped\"}"
    })
  }
}

resource "aws_scheduler_schedule" "stop_rds" {
  #checkov:skip=CKV_AWS_297
  name = "stop-non-prod-rds"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.shutdown_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_start_stop_rds_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"status\": \"available\"}"
    })
  }
}

resource "aws_scheduler_schedule" "start_rds" {
  #checkov:skip=CKV_AWS_297
  name = "start-non-prod-rds"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(40 ${var.startup_hour - 1} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_start_stop_rds_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"status\": \"stopped\"}"
    })
  }
}

########## Update Auto Scaling for EC2 Instances ##############

resource "aws_scheduler_schedule" "scale_out" {
  name = "scale_out_asg"
  #checkov:skip=CKV_AWS_297

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.startup_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_update_scale_asg_ec2_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"asg_scale\": \"scale-out\"}"
    })
  }
}

resource "aws_scheduler_schedule" "scale_in" {
  name = "scale_in_asg"
  #checkov:skip=CKV_AWS_297

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.shutdown_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_update_scale_asg_ec2_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"asg_scale\": \"scale-in\"}"
    })
  }
}

########## Update Auto Scaling for ECS Tasks ##############

resource "aws_scheduler_schedule" "scale_in_ecs" {
  name = "scale_in_ecs_asg"
  #checkov:skip=CKV_AWS_297

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.shutdown_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_update_scale_asg_ecs_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"ecs_scale\": \"scale-in\"}"
    })
  }
}

resource "aws_scheduler_schedule" "scale_out_ecs" {
  name = "scale_out_ecs_asg"
  #checkov:skip=CKV_AWS_297

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression          = "cron(00 ${var.startup_hour} ? * MON-FRI *)"
  schedule_expression_timezone = "Asia/Singapore"

  target {
    arn      = var.lambda_function_update_scale_asg_ecs_arn
    role_arn = module.instance_scheduler_role.iam_role_arn
    input = jsonencode({
      "body" : "{\"ecs_scale\": \"scale-out\"}"
    })
  }
}
