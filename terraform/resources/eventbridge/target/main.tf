# Amazon Event Bridge Event Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

resource "aws_cloudwatch_event_target" "this" {
  arn            = var.arn
  event_bus_name = var.event_bus_name
  input          = var.input_path != null ? templatefile(var.path, var.vars) : null
  role_arn       = var.role_arn
  rule           = var.rule
  target_id      = var.target_id
}
