## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.62.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch"></a> [cloudwatch](#module\_cloudwatch) | ../../resources/cloudwatch/log_group | n/a |
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ../../resources/ecr | n/a |
| <a name="module_event_rule"></a> [event\_rule](#module\_event\_rule) | ../../resources/eventbridge/rule | n/a |
| <a name="module_event_target"></a> [event\_target](#module\_event\_target) | ../../resources/eventbridge/target | n/a |
| <a name="module_function"></a> [function](#module\_function) | ../../resources/lambda/function | n/a |
| <a name="module_iam_policy"></a> [iam\_policy](#module\_iam\_policy) | ../../resources/iam/policy | n/a |
| <a name="module_iam_role"></a> [iam\_role](#module\_iam\_role) | ../../resources/iam/role | n/a |
| <a name="module_permission"></a> [permission](#module\_permission) | ../../resources/lambda/permission | n/a |

## Resources

| Name | Type |
|------|------|
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account"></a> [account](#input\_account) | A map of AWS account ID. | `map(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | A map of AWS region. | `map(string)` | n/a | yes |
| <a name="input_slack_webhook_url"></a> [slack\_webhook\_url](#input\_slack\_webhook\_url) | Slack webhook URL. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | n/a | yes |

## Outputs

No outputs.
