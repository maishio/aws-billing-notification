# Amazon EventBridge Rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

output "cloudwatch_event_rule" {
  description = "Amazon EventBridge Rule resource."
  value       = aws_cloudwatch_event_rule.this
}
