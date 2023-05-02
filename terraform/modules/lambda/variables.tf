variable "account" {
  description = "A map of AWS account ID."
  type        = map(string)
}

variable "slack_webhook_url" {
  description = "Slack webhook URL."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}
