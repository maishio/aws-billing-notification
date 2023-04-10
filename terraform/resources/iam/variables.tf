# AWS IAM Role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

variable "description" {
  description = "Description of the role."
  type        = string
  default     = null
}

variable "role_name" {
  description = "Name of the role."
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path to the role policy."
  type        = string
}

variable "role_vars" {
  description = "Variables to be used in the role policy."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

# AWS IAM Policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy

variable "path" {
  description = "Path in which to create the policy."
  type        = string
  default     = "/"
}

variable "policy_name" {
  description = "Name of the policy."
  type        = string
  default     = null
}

variable "policy_path" {
  description = "Path to the policy."
  type        = string
  default     = null
}

variable "policy_vars" {
  description = "Variables to be used in the policy."
  type        = map(string)
  default     = {}
}

# AWS IAM Instance Profile
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile

variable "create_iam_instance_profile" {
  description = "Whether to create an IAM instance profile."
  type        = bool
  default     = false
}

variable "profile_name" {
  description = "Name of the instance profile."
  type        = string
  default     = null
}
