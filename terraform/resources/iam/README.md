# AWS IAM Terraform Resource

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.3.0 |

## Providers

| Name | Version   |
|------|-----------|
| aws  | ~> 4.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_iam_instance_profile"></a> [create\_iam\_instance\_profile](#input\_create\_iam\_instance\_profile) | Whether to create an IAM instance profile. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the role. | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the policy. | `string` | `"/"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of the policy. | `string` | `null` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path to the policy. | `string` | `null` | no |
| <a name="input_policy_vars"></a> [policy\_vars](#input\_policy\_vars) | Variables to be used in the policy. | `map(string)` | `{}` | no |
| <a name="input_profile_name"></a> [profile\_name](#input\_profile\_name) | Name of the instance profile. | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the role. | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path to the role policy. | `string` | n/a | yes |
| <a name="input_role_vars"></a> [role\_vars](#input\_role\_vars) | Variables to be used in the role policy. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_instance_profile"></a> [iam\_instance\_profile](#output\_iam\_instance\_profile) | n/a |
| <a name="output_iam_role"></a> [iam\_role](#output\_iam\_role) | n/a |
