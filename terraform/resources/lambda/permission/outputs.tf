# AWS Lambda Permission
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission

output "lambda_permission" {
  value = aws_lambda_permission.this
}
