module "eventbridge" {
  source = "git::https://github.com/norishio2022/terraform-aws-resources.git//eventbridge"

  # --------------------------------------------------------------------------------
  # Amazon EventBridge Rules
  # @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule
  # --------------------------------------------------------------------------------

  description         = "AWS利用料金通知イベント"
  is_enabled          = true
  name                = "${var.tags.service}-${var.tags.env}-billing-notification-events"
  schedule_expression = "cron(0 0 * * ? *)"
  tags                = var.tags

  # --------------------------------------------------------------------------------
  # Amazon EventBridge Target
  # @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target
  # --------------------------------------------------------------------------------

  target_id = "${var.tags.service}-${var.tags.env}-billing-notification-target"
  arn       = module.lambda.lambda_function.arn
}
