module "lambda" {
  source = "git::https://github.com/norishio2022/terraform-aws-resources.git//lambda"

  # --------------------------------------------------------------------------------
  # AWS Lambda Function
  # @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function
  # --------------------------------------------------------------------------------

  description      = "AWS利用料金Teams通知"
  filename         = data.archive_file.this.output_path
  function_name    = "${var.tags.service}-${var.tags.env}-billing-notification-function"
  handler          = "app.lambda_handler"
  memory_size      = 512
  role             = module.iam.iam_role.arn
  source_code_hash = data.archive_file.this.output_base64sha256
  runtime          = "python3.8"
  tags             = var.tags
  timeout          = 180
  environments = [
    {
      variables = {
        TEAMS_WEBHOOK_URL = var.TEAMS_WEBHOOK_URL
      }
    }
  ]

  # --------------------------------------------------------------------------------
  # AWS Lambda Permission
  # @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission
  # --------------------------------------------------------------------------------

  action       = "lambda:InvokeFunction"
  principal    = "events.amazonaws.com"
  source_arn   = module.eventbridge.cloudwatch_event_rule.arn
  statement_id = "${var.tags.service}-${var.tags.env}-billing-notification-permission"
  depends_on   = [module.iam.aws_iam_role]
}
