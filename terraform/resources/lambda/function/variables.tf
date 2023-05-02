# AWS Lambda Function
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function

variable "description" {
  description = "Description of the Lambda function."
  type        = string
  default     = null
}

variable "environments" {
  description = "A list of environment objects for the dynamic block."
  type        = any
  default     = []
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem."
  type        = string
  default     = null
}

variable "function_name" {
  description = "Name of the function."
  type        = string
  default     = null
}

variable "handler" {
  description = "Function entrypoint in your code."
  type        = string
  default     = null
}

variable "image_uri" {
  description = "URI of a container image in the Amazon ECR registry."
  type        = string
  default     = null
}

variable "layers" {
  description = "A list of Lambda layer ARNs to attach to your Lambda function."
  type        = list(string)
  default     = []
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda function can use at runtime. Defaults to `128`."
  type        = number
  default     = 128
}

variable "package_type" {
  description = "The type of deployment package. Valid values are `Zip` and `Image`. Defaults to `Zip`."
  type        = string
  default     = "Zip"
}

variable "role" {
  description = "ARN of the function's execution role."
  type        = string
  default     = null
}

variable "runtime" {
  description = "Identifier of the function's runtime."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file."
  type        = string
  default     = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Amount of time your Lambda Function has to run in seconds. Defaults to `3`."
  type        = number
  default     = 3
}

variable "vpc_config" {
  description = "A list of VPC configuration objects for the dynamic block."
  type        = any
  default     = []
}
