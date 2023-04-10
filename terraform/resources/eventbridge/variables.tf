# Amazon Event Bridge Event Rule
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

# Amazon Event Bridge Event Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

variable "arn" {
  description = "ARN of the target."
  type        = string
}

variable "input_path" {
  description = "Path to the input file."
  type        = string
  default     = null
}

variable "input_vars" {
  description = "Variables to be used in the input file."
  type        = map(string)
  default     = {}
}

variable "role_arn" {
  description = "ARN of the IAM role to be used for this target when the rule is triggered."
  type        = string
  default     = null
}

variable "target_id" {
  description = "The unique target assignment ID. If missing, will generate a random, unique id."
  type        = string
  default     = null
}
