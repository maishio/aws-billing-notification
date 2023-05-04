module "cloudwatch" {
  source            = "../../resources/cloudwatch/log_group"
  name              = "/aws/lambda/${var.tags.service}-${var.tags.env}-notify-aws-billing"
  retention_in_days = 7
  tags              = var.tags
}
