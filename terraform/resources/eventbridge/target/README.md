# Amazon EventBridge Target Terraform Resource

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.4.0 |

## Providers

| Name | Version   |
| ---- | --------- |
| aws  | ~> 4.62.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                    | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_cloudwatch_event_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |

## Inputs

| Name                                                                        | Description                                                                                   | Type          | Default     | Required |
| --------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | ------------- | ----------- | :------: |
| <a name="input_arn"></a> [arn](#input_arn)                                  | ARN of the target.                                                                            | `string`      | n/a         |   yes    |
| <a name="input_event_bus_name"></a> [event_bus_name](#input_event_bus_name) | Name of the event bus to associate with this rule. If omitted, the default event bus is used. | `string`      | `"default"` |    no    |
| <a name="input_path"></a> [path](#input_path)                               | Path to the input file.                                                                       | `string`      | `null`      |    no    |
| <a name="input_role_arn"></a> [role_arn](#input_role_arn)                   | ARN of the IAM role to be used for this target when the rule is triggered.                    | `string`      | `null`      |    no    |
| <a name="input_rule"></a> [rule](#input_rule)                               | Name of the rule you want to add targets to.                                                  | `string`      | n/a         |   yes    |
| <a name="input_target_id"></a> [target_id](#input_target_id)                | The unique target assignment ID. If missing, will generate a random, unique id.               | `string`      | `null`      |    no    |
| <a name="input_vars"></a> [vars](#input_vars)                               | Variables to be used in the input file.                                                       | `map(string)` | `{}`        |    no    |

## Outputs

| Name                                                                                                     | Description                         |
| -------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| <a name="output_cloudwatch_event_target"></a> [cloudwatch_event_target](#output_cloudwatch_event_target) | Amazon EventBridge Target resource. |
