module "lambda_layer" {
  source              = "../../resources/lambda_layer"
  compatible_runtimes = ["python3.9"]
  filename            = data.archive_file.library.output_path
  layer_name          = "${var.tags.service}-${var.tags.env}-billing-notification-function"
  source_code_hash    = data.archive_file.library.output_base64sha256
}
