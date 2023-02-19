################################################################################
# IAM Policy and IAM Role
################################################################################
module "iam_policy_instance_maintenance" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.13.0"

  name = "${var.standard_tags.product}-policy"
  # path        = "/"
  description = "IAM Policy to stop and start Non-asg ec2 and rds resources"

  policy = data.aws_iam_policy_document.instance_scheduler_policy.json
}

# module "iam_policy_trigger_lambda" {
#   source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
#   version = "~> 4.13.0"

#   name = "lambda-${var.standard_tags.product}-policy"
#   # path        = "/"
#   description = "IAM Policy to to trigger lambda function"

#   policy = data.aws_iam_policy_document.eventbridge_schedule_policy.json
# }

# resource "aws_iam_role_policy_attachment" "eventbridge_role_attachment" {
#   role       = module.instance_scheduler_role.iam_role_name
#   policy_arn = module.iam_policy_trigger_lambda.arn
# }

resource "aws_iam_role_policy_attachment" "ec2_stop_role_attachment" {
  role       = module.lambda_function_stop_ec2.lambda_function_name
  policy_arn = module.iam_policy_instance_maintenance.arn
}

resource "aws_iam_role_policy_attachment" "ec2_start_role_attachment" {
  role       = module.lambda_function_start_ec2.lambda_function_name
  policy_arn = module.iam_policy_instance_maintenance.arn
}

resource "aws_iam_role_policy_attachment" "rds_stop_role_attachment" {
  role       = module.lambda_function_stop_rds.lambda_function_name
  policy_arn = module.iam_policy_instance_maintenance.arn
}

resource "aws_iam_role_policy_attachment" "rds_start_role_attachment" {
  role       = module.lambda_function_start_rds.lambda_function_name
  policy_arn = module.iam_policy_instance_maintenance.arn
}
