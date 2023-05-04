module "iam_role" {
  source      = "../../resources/iam/role"
  description = "Notify AWS Billing Lambda function execution IAM role."
  name        = "${var.tags.service}-${var.tags.env}-notify-aws-billing-role"
  path        = "${path.module}/files/template/default_iam_assume_role.json.tpl"
  vars = {
    SERVICE = "lambda.amazonaws.com"
  }
  tags = var.tags
}

module "iam_policy" {
  source                            = "../../resources/iam/policy"
  create_iam_role_policy_attachment = true
  description                       = "Notify AWS Billing Lambda function execution IAM policy."
  name                              = "${var.tags.service}-${var.tags.env}-notify-aws-billing-policy"
  role                              = module.iam_role.iam_role.name
  path                              = "${path.module}/files/template/notify_aws_billing_policy.json.tpl"
  tags                              = var.tags
}
