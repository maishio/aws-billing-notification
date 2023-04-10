# AWS Lambda Layer Version
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version

output "lambda_layer_version" {
  value = aws_lambda_layer_version.this
}
