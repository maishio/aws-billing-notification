# AWS Lambda Function Archive File
# https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file

data "archive_file" "function" {
  type        = "zip"
  source_dir  = "./files/function/source"
  output_path = "./files/function/output/function.zip"
}

# AWS Lambda Layer Archive File
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version

data "archive_file" "library" {
  type        = "zip"
  source_dir  = "./files/library/source"
  output_path = "./files/library/output/library.zip"
}
