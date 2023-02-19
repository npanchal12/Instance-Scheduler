output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = try(module.iam_assumable_role.iam_role_arn, "")
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = try(module.iam_assumable_role.iam_role_name, "")
}
