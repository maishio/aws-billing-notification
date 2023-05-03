# Amazon EventBridge Target
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target

variable "arn" {
  description = "ARN of the target."
  type        = string
}

variable "event_bus_name" {
  description = "Name of the event bus to associate with this rule. If omitted, the default event bus is used."
  type        = string
  default     = "default"
}

variable "path" {
  description = "Path to the input file."
  type        = string
  default     = null
}

variable "role_arn" {
  description = "ARN of the IAM role to be used for this target when the rule is triggered."
  type        = string
  default     = null
}

variable "rule" {
  description = "Name of the rule you want to add targets to."
  type        = string
}

variable "target_id" {
  description = "The unique target assignment ID. If missing, will generate a random, unique id."
  type        = string
  default     = null
}

variable "vars" {
  description = "Variables to be used in the input file."
  type        = map(string)
  default     = {}
}
