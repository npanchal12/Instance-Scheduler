resource "aws_scheduler_schedule" "example" {
  name = "my-schedule"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression = "cron(0 10 * * ? *)"

  target {
    arn      = var.lambda_function_arn
    role_arn = var.instance_scheduler_role
  }
}
