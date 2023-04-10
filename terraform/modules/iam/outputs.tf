output "iam_role_arn" {
  description = "ARN of the IAM role for Lambda function."
  value       = module.iam.iam_role.arn
}
