module "ecr" {
  source       = "../../resources/ecr"
  force_delete = true
  name         = "${var.tags.service}-${var.tags.env}-notify-aws-billing"
  path         = "${path.module}/files/template/ecr_lifecycle_policy.json.tpl"
  tags         = var.tags
}

resource "null_resource" "this" {
  triggers = {
    arn = module.ecr.ecr_repository.arn
  }
  provisioner "local-exec" {
    command = <<EOT
      cd files/app
      aws ecr get-login-password --region ${var.region.id} | docker login --username AWS --password-stdin ${var.account.id}.dkr.ecr.${var.region.id}.amazonaws.com
      docker build --platform linux/amd64 -t ${var.account.id}.dkr.ecr.${var.region.id}.amazonaws.com/${var.tags.service}-${var.tags.env}-notify-aws-billing:latest --target production .
      docker push ${var.account.id}.dkr.ecr.${var.region.id}.amazonaws.com/${var.tags.service}-${var.tags.env}-notify-aws-billing:latest
    EOT
  }
  depends_on = [module.ecr]
}
