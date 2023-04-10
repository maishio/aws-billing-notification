module "cloudwatch" {
  source            = "../../resources/cloudwatch"
  name              = "/aws/lambda/${var.tags.service}-${var.tags.env}-billing-notification-function"
  retention_in_days = 7
  tags              = var.tags
}
