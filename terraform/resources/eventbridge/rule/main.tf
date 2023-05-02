# Amazon EventBridge Rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

resource "aws_cloudwatch_event_rule" "this" {
  description         = var.description
  event_bus_name      = var.event_bus_name
  event_pattern       = var.event_path != null ? templatefile(var.event_path, var.event_vars) : null
  is_enabled          = var.is_enabled
  name                = var.name
  schedule_expression = var.schedule_expression
  tags                = merge(var.tags, { "Name" = var.name })

  lifecycle {
    ignore_changes = [
      is_enabled,
      schedule_expression
    ]
  }
}
