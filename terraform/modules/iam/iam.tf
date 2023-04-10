module "iam" {
  source = "../../resources/iam"

  # AWS IAM Role for Lambda Function
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

  role_name = "${var.tags.service}-${var.tags.env}-billing-notification-role"
  role_path = "${path.module}/files/template/default_iam_assume_role.json.tpl"
  role_vars = {
    SERVICE = "lambda.amazonaws.com"
  }
  tags = var.tags

  # AWS IAM Policy for Lambda Function
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

  policy_path = "${path.module}/files/template/billing_notification_iam_policy.json.tpl"
  policy_name = "${var.tags.service}-${var.tags.env}-billing-notification-policy"
}
