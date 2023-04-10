# Amazon Event Bridge Event Rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

output "cloudwatch_event_rule" {
  value = aws_cloudwatch_event_rule.this
}

# Amazon Event Bridge Event Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

output "cloudwatch_event_target" {
  value = aws_cloudwatch_event_target.this
}
