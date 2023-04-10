module "eventbridge" {
  source = "../../resources/eventbridge"

  # Amazon EventBridge Event Rules
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

  description         = "AWS Billing Notification Event Rule"
  is_enabled          = true
  name                = "${var.tags.service}-${var.tags.env}-billing-notification"
  schedule_expression = "cron(0 0 * * ? *)"
  tags                = var.tags

  # Amazon EventBridge Event Target
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

  target_id = "${var.tags.service}-${var.tags.env}-billing-notification"
  arn       = module.lambda.lambda_function.arn
}
