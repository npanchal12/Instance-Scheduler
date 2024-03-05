resource "aws_iam_role_policy_attachment" "rds_start_stop_role_attachment" {
  role       = module.lambda_function_start_stop_rds.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_role_policy_attachment" "non_asg_ec2_start_stop_role_attachment" {
  role       = module.lambda_function_start_stop_non_asg_ec2.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_policy" "instance_scheduler_policy" {
  name_prefix = "iam_policy_instance_maintenance-policy"
  policy      = data.aws_iam_policy_document.instance_scheduler_policy.json
}

########### Auto-scaling-update-role
resource "aws_iam_role_policy_attachment" "update_scale_asg" {
  role       = module.lambda_function_udpate_scale_asg.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}

resource "aws_iam_role_policy_attachment" "update_ecs_scale_asg" {
  role       = module.lambda_function_udpate_ecs_scale_asg.lambda_function_name
  policy_arn = aws_iam_policy.instance_scheduler_policy.arn
}
