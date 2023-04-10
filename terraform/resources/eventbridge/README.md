# Amazon EventBridge Terraform Resource

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
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_arn"></a> [arn](#input\_arn) | ARN of the target. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description of the rule. | `string` | `null` | no |
| <a name="input_event_bus_name"></a> [event\_bus\_name](#input\_event\_bus\_name) | Name of the event bus to associate with this rule. If omitted, the default event bus is used. | `string` | `"default"` | no |
| <a name="input_event_path"></a> [event\_path](#input\_event\_path) | Path to the event pattern file. | `string` | `null` | no |
| <a name="input_event_vars"></a> [event\_vars](#input\_event\_vars) | Variables to be used in the event pattern file. | `map(string)` | `{}` | no |
| <a name="input_input_path"></a> [input\_path](#input\_input\_path) | Path to the input file. | `string` | `null` | no |
| <a name="input_input_vars"></a> [input\_vars](#input\_input\_vars) | Variables to be used in the input file. | `map(string)` | `{}` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether the rule should be enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the rule. | `string` | `null` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | ARN of the IAM role to be used for this target when the rule is triggered. | `string` | `null` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | Scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_target_id"></a> [target\_id](#input\_target\_id) | The unique target assignment ID. If missing, will generate a random, unique id. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_event_rule"></a> [cloudwatch\_event\_rule](#output\_cloudwatch\_event\_rule) | n/a |
| <a name="output_cloudwatch_event_target"></a> [cloudwatch\_event\_target](#output\_cloudwatch\_event\_target) | n/a |
