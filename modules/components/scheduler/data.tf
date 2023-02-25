data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "eventbridge_schedule_policy" {

  statement {
    sid = "invokelambdafunction"
    actions = [
      "lambda:InvokeFunction"
    ]
    effect = "Allow"
    resources = [
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_stop_ec2_name}*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_stop_ec2_name}:*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_ec2_name}*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_ec2_name}:*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_stop_rds_name}*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_stop_rds_name}:*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_rds_name}*",
      # "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_rds_name}:*"
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_stop_rds_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_stop_rds_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_stop_non_asg_ec2_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${var.lambda_function_start_stop_non_asg_ec2_name}:*"
    ]
  }
}
