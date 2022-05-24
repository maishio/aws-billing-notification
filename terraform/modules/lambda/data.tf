# --------------------------------------------------------------------------------
# Lambda Function archive file
# @see https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/archive_file
# --------------------------------------------------------------------------------

data "archive_file" "this" {
  type        = "zip"
  source_dir  = "./files/functions/billing-notification/source"
  output_path = "./files/functions/billing-notification/output/function.zip"
}
