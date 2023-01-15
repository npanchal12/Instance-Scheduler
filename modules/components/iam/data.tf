# data "aws_region" "current" {}

# data "aws_caller_identity" "current" {}

# data "aws_iam_policy_document" "scheduler_document" {
#   #checkov:skip=CKV_AWS_111
#   statement {
#     actions   = ["logs:CreateLogGroup"]
#     resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/ecs/ecs-${var.name}/*"]
#   }
#   statement {
#     sid = "taskexecution"

#     actions = [
#       "ecr:GetAuthorizationToken",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:BatchGetImage",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents"
#     ]

#     resources = [
#       "*",
#     ]
#   }
# }
