# AWS Lambda Layer Version
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version

resource "aws_lambda_layer_version" "this" {
  compatible_runtimes = var.compatible_runtimes
  filename            = var.filename
  layer_name          = var.layer_name
  source_code_hash    = var.source_code_hash
}
