# Amazon EventBridge Rule
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule

variable "description" {
  description = "Description of the rule."
  type        = string
  default     = null
}

variable "event_bus_name" {
  description = "Name of the event bus to associate with this rule. If omitted, the default event bus is used."
  type        = string
  default     = "default"
}

variable "event_path" {
  description = "Path to the event pattern file."
  type        = string
  default     = null
}

variable "event_vars" {
  description = "Variables to be used in the event pattern file."
  type        = map(string)
  default     = {}
}

variable "is_enabled" {
  description = "Whether the rule should be enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of the rule."
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "Scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
