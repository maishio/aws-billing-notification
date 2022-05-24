module "iam" {
  source = "git::https://github.com/norishio2022/terraform-aws-resources.git//iam"

  # --------------------------------------------------------------------------------
  # Lambda function IAM Role
  # @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # --------------------------------------------------------------------------------

  role_name = "${var.tags.service}-${var.tags.env}-billing-notification-role"
  role_path = "${path.module}/files/template/default_iam_assume_role.json.tpl"
  role_vars = {
    SERVICE = "lambda.amazonaws.com"
  }
  tags = var.tags

  # --------------------------------------------------------------------------------
  # Lambda function IAM Policy
  # @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
  # --------------------------------------------------------------------------------

  policy_path = "${path.module}/files/template/billing_notification_iam_policy.json.tpl"
  policy_name = "${var.tags.service}-${var.tags.env}-billing-notification-policy"
}
