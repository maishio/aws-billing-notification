module "event_rule" {
  source              = "../../resources/eventbridge/rule"
  description         = "Notify AWS Billing Event Rule"
  is_enabled          = true
  name                = "${var.tags.service}-${var.tags.env}-notify-aws-billing"
  schedule_expression = "cron(0 0 * * ? *)"
  tags                = var.tags
}

module "event_target" {
  source    = "../../resources/eventbridge/target"
  rule      = module.event_rule.cloudwatch_event_rule.name
  target_id = "${var.tags.service}-${var.tags.env}-notify-aws-billing"
  arn       = module.function.lambda_function.arn
}
