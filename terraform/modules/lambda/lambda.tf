module "lambda" {
  source = "../../resources/lambda"

  # AWS Lambda Function
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

  description      = "AWS Billing Notification Function"
  filename         = data.archive_file.function.output_path
  function_name    = "${var.tags.service}-${var.tags.env}-billing-notification-function"
  handler          = "app.lambda_handler"
  layers           = [module.lambda_layer.lambda_layer_version.arn]
  memory_size      = 512
  role             = var.iam_role_arn
  source_code_hash = data.archive_file.function.output_base64sha256
  runtime          = "python3.9"
  tags             = var.tags
  timeout          = 180
  environments = [
    {
      variables = {
        TEAMS_WEBHOOK_URL = var.teams_webhook_url
      }
    }
  ]

  # AWS Lambda Permission
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission

  principal  = "events.amazonaws.com"
  source_arn = module.eventbridge.cloudwatch_event_rule.arn
}
