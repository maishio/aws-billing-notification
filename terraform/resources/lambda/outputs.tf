# AWS Lambda Function
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

output "lambda_function" {
  value = aws_lambda_function.this
}
