output "role_arns" {
  description = "ARN of the IAM roles."
  value       = { for role in aws_iam_role.roles : role.name => role.arn }
}
