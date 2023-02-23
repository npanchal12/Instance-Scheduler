resource "aws_iam_policy" "eventbridge_schedule_policy" {
  name_prefix = "${var.app_name}-policy"
  policy      = data.aws_iam_policy_document.eventbridge_schedule_policy.json
}

module "instance_scheduler_role" {
  source = "../iam"

  trusted_role_services = ["lambda.amazonaws.com",
  "scheduler.amazonaws.com"]
  role_name = "${var.app_name}-role"
  custom_role_policy_arns = [
    aws_iam_policy.eventbridge_schedule_policy.arn,
  ]
}
