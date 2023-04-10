# AWS IAM Role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

output "iam_role" {
  value = aws_iam_role.this
}

# AWS IAM Instance Profile
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile

output "iam_instance_profile" {
  value = aws_iam_instance_profile.this
}
