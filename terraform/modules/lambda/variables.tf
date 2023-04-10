variable "account" {
  description = "A map of AWS account ID."
  type        = map(string)
}

variable "iam_role_arn" {
  description = "ARN of the IAM role to assume."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
}

variable "teams_webhook_url" {
  description = "URL of the Teams webhook."
  type        = string
}
