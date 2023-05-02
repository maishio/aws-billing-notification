# Amazon EventBridge Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

output "cloudwatch_event_target" {
  description = "Amazon EventBridge Target resource."
  value       = aws_cloudwatch_event_target.this
}
