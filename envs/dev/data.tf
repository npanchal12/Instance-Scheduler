data "aws_region" "current" {}

data "aws_caller_identity" "current" {}


data "aws_iam_policy_document" "instance_scheduler_policy" {

  statement {
    sid = "allowresourcestopstart"
    actions = [
      "ec2:DescribeInstances",
      "ec2:DescribeInstances",
      "ec2:StartInstances",
      "ec2:DescribeTags",
      "logs:*",
      "ec2:DescribeInstanceTypes",
      "ec2:StopInstances",
      "ec2:DescribeInstanceStatus",
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:StartDBCluster",
      "rds:StopDBCluster",
    ]
    effect = "Allow"
    resources = [
      "*"
    ]
  }

  statement {
    sid = "invokelambdafunction"
    actions = [
      "lambda:InvokeFunction"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_ec2.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_ec2.lambda_function_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_ec2.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_ec2.lambda_function_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_rds.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_rds.lambda_function_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_rds.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_rds.lambda_function_name}:*"
    ]
  }
}
  # statement {
  #   sid = "invokelambdafunction"
  #   actions = [
  #     "lambda:InvokeFunction"
  #   ]
  #   effect = "Allow"
  #   resources = [
  #     "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_ec2.lambda_function_name}*",
  #     "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_ec2.lambda_function_name}:*",
  #     "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_ec2.lambda_function_name}*",
  #     "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_ec2.lambda_function_name}:*"
  #   ]
  # }
# }

data "aws_iam_policy_document" "eventbridge_schedule_policy" {

  statement {
    sid = "invokelambdafunction"
    actions = [
      "lambda:InvokeFunction"
    ]
    effect = "Allow"
    resources = [
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_ec2.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_ec2.lambda_function_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_ec2.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_ec2.lambda_function_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_rds.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_stop_rds.lambda_function_name}:*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_rds.lambda_function_name}*",
      "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.id}:function:${module.lambda_function_start_rds.lambda_function_name}:*"
    ]
  }
}
