module "cloudwatch" {
  source            = "../../resources/cloudwatch/log_group"
  name              = "/aws/lambda/notify-aws-billing"
  retention_in_days = 7
  tags              = var.tags
}
