# AWS Lambda Layer Version
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version

variable "compatible_runtimes" {
  description = "List of Architectures this layer is compatible with. Currently `x86_64` and `arm64` can be specified."
  type        = list(string)
  default     = []
}

variable "filename" {
  description = "Path to the function's deployment package within the local filesystem."
  type        = string
  default     = null
}

variable "layer_name" {
  description = "Name of the Lambda Layer."
  type        = string
  default     = null
}

variable "source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file. Used to trigger updates."
  type        = string
  default     = null
}
