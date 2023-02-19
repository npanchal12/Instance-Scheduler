# resource "aws_iam_role_policy_attachment" "eventbridge_role_attachment" {
#   role       = module.instance_scheduler_role.iam_role_name
#   policy_arn = module.iam_policy_trigger_lambda.arn
# }


resource "aws_iam_policy" "eventbridge_schedule_policy" {
  name_prefix = "eventbridge-${var.app_name}"
  policy      = data.aws_iam_policy_document.eventbridge_schedule_policy.json
}

module "instance_scheduler_role" {
  source = "../iam"

  trusted_role_services = ["lambda.amazonaws.com",
  "scheduler.amazonaws.com"]
#   create_role             = true
#   create_instance_profile = false
#   role_requires_mfa       = false
  role_name               = "${var.app_name}-role"
  custom_role_policy_arns = [
    aws_iam_policy.eventbridge_schedule_policy.arn,
  ]
}

module "iam_policy_trigger_lambda" {
  source = "../iam"
#   source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
#   version = "~> 4.13.0"

  name = "lambda-${var.app_name}-policy"
  # path        = "/"
  description = "IAM Policy to to trigger lambda function"

  policy = data.aws_iam_policy_document.eventbridge_schedule_policy.json
}
