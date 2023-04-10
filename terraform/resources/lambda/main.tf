# AWS Lambda Function
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

resource "aws_lambda_function" "this" {
  description      = var.description
  filename         = var.filename
  function_name    = var.function_name
  handler          = var.handler
  image_uri        = var.image_uri
  layers           = var.layers
  memory_size      = var.memory_size
  package_type     = var.package_type
  role             = var.role
  runtime          = var.runtime
  source_code_hash = var.source_code_hash
  tags             = merge(var.tags, { "Name" = var.function_name })
  timeout          = var.timeout

  dynamic "environment" {
    for_each = var.environments
    content {
      variables = environment.value.variables
    }
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config
    content {
      security_group_ids = vpc_config.value.security_group_ids
      subnet_ids         = vpc_config.value.subnet_ids
    }
  }

  lifecycle {
    ignore_changes = [
      filename,
      last_modified,
      qualified_arn,
      version,
    ]
  }
}

# AWS Lambda Permission
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission

resource "aws_lambda_permission" "this" {
  action        = var.action
  function_name = aws_lambda_function.this.function_name
  principal     = var.principal
  source_arn    = var.source_arn
  statement_id  = var.statement_id
}

# Amazon S3 Bucket Notification
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_notification

resource "aws_s3_bucket_notification" "this" {
  count  = var.create_s3_bucket_notification ? 1 : 0
  bucket = var.bucket
  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:*"]
  }
}
