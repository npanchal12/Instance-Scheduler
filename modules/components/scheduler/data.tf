data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "eventbridge_schedule_policy" {
  statement {
    sid     = "invokelambdafunction"
    actions = ["lambda:InvokeFunction"]
    effect  = "Allow"
    resources = [
      "${local.arn_prefix}${var.lambda_function_start_stop_rds_name}*",
      "${local.arn_prefix}${var.lambda_function_start_stop_rds_name}:*",
      "${local.arn_prefix}${var.lambda_function_start_stop_non_asg_ec2_name}*",
      "${local.arn_prefix}${var.lambda_function_start_stop_non_asg_ec2_name}:*",
      "${local.arn_prefix}${var.lambda_function_update_scale_asg_ec2_name}*",
      "${local.arn_prefix}${var.lambda_function_update_scale_asg_ec2_name}:*",
      "${local.arn_prefix}${var.lambda_function_update_scale_asg_ecs_name}*",
      "${local.arn_prefix}${var.lambda_function_update_scale_asg_ecs_name}:*",
    ]
  }
}
