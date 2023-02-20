resource "aws_iam_role_policy_attachment" "ec2_stop_role_attachment" {
  role       = module.lambda_function_stop_ec2.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_role_policy_attachment" "ec2_start_role_attachment" {
  role       = module.lambda_function_start_ec2.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_role_policy_attachment" "rds_stop_role_attachment" {
  role       = module.lambda_function_stop_rds.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_role_policy_attachment" "rds_start_role_attachment" {
  role       = module.lambda_function_start_rds.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_policy" "instance_scheduler_policy" {
  name_prefix = "iam_policy_instance_maintenance-policy"
  policy      = data.aws_iam_policy_document.instance_scheduler_policy.json
}
