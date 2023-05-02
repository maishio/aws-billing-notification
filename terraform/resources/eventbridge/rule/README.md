# Amazon EventBridge Rule Terraform Resource

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

| Name                                                                                                                                | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_cloudwatch_event_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |

## Inputs

| Name                                                                                       | Description                                                                                   | Type          | Default     | Required |
| ------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------- | ------------- | ----------- | :------: |
| <a name="input_description"></a> [description](#input_description)                         | Description of the rule.                                                                      | `string`      | `null`      |    no    |
| <a name="input_event_bus_name"></a> [event_bus_name](#input_event_bus_name)                | Name of the event bus to associate with this rule. If omitted, the default event bus is used. | `string`      | `"default"` |    no    |
| <a name="input_event_path"></a> [event_path](#input_event_path)                            | Path to the event pattern file.                                                               | `string`      | `null`      |    no    |
| <a name="input_event_vars"></a> [event_vars](#input_event_vars)                            | Variables to be used in the event pattern file.                                               | `map(string)` | `{}`        |    no    |
| <a name="input_is_enabled"></a> [is_enabled](#input_is_enabled)                            | Whether the rule should be enabled. Defaults to true.                                         | `bool`        | `true`      |    no    |
| <a name="input_name"></a> [name](#input_name)                                              | Name of the rule.                                                                             | `string`      | `null`      |    no    |
| <a name="input_schedule_expression"></a> [schedule_expression](#input_schedule_expression) | Scheduling expression. For example, cron(0 20 \* _ ? _) or rate(5 minutes).                   | `string`      | `null`      |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                              | A mapping of tags to assign to the resource.                                                  | `map(string)` | `{}`        |    no    |

## Outputs

| Name                                                                                               | Description                       |
| -------------------------------------------------------------------------------------------------- | --------------------------------- |
| <a name="output_cloudwatch_event_rule"></a> [cloudwatch_event_rule](#output_cloudwatch_event_rule) | Amazon EventBridge Rule resource. |
