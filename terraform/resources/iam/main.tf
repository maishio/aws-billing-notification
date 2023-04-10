# AWS IAM Role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

resource "aws_iam_role" "this" {
  description        = var.description
  name               = var.role_name
  assume_role_policy = templatefile(var.role_path, var.role_vars)
  tags               = merge(var.tags, { "Name" = var.role_name })
}

# AWS IAM Policy
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy

resource "aws_iam_policy" "this" {
  name   = var.policy_name
  path   = var.path
  policy = templatefile(var.policy_path, var.policy_vars)
  tags   = merge(var.tags, { "Name" = var.policy_name })
}

# AWS IAM Role Policy Attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
  depends_on = [aws_iam_role.this]
}

# AWS IAM Instance Profile
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile

resource "aws_iam_instance_profile" "this" {
  count      = var.create_iam_instance_profile ? 1 : 0
  name       = var.profile_name
  role       = aws_iam_role.this.name
  depends_on = [aws_iam_role.this]
}
