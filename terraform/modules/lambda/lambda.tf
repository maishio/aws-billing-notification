module "function" {
  source        = "../../resources/lambda/function"
  description   = "Daily notifications of aws billing to your slack."
  function_name = "${var.tags.service}-${var.tags.env}-notify-aws-billing"
  memory_size   = 512
  package_type  = "Image"
  image_uri     = "${module.ecr.ecr_repository.repository_url}:latest"
  role          = module.iam_role.iam_role.arn
  runtime       = "python3.9"
  tags          = var.tags
  timeout       = 60
  environments = [
    {
      variables = {
        SLACK_WEBHOOK_URL = var.slack_webhook_url
      }
    }
  ]
  depends_on = [null_resource.this]
}

module "permission" {
  source        = "../../resources/lambda/permission"
  function_name = module.function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = module.event_rule.cloudwatch_event_rule.arn
}
