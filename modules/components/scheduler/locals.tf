locals {
  aws_region          = data.aws_region.current.name
  aws_caller_identity = data.aws_caller_identity.current.id
  arn_prefix          = "arn:aws:lambda:${local.aws_region}:${local.aws_caller_identity}:function:"
}
