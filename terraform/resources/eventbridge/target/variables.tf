# Amazon EventBridge Target
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
