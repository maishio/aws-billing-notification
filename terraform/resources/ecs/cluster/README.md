# Amazon ECS Cluster Terraform Resource

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.4.0 |

## Providers

| Name | Version   |
| ---- | --------- |
| aws  | ~> 4.57.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                  | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster)                                       | resource |
| [aws_ecs_cluster_capacity_providers.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster_capacity_providers) | resource |

## Inputs

| Name                                                                                                                                    | Description                                                                   | Type                | Default               | Required |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ------------------- | --------------------- | :------: |
| <a name="input_capacity_providers"></a> [capacity_providers](#input_capacity_providers)                                                 | Set of names of one or more capacity providers to associate with the cluster. | `list(string)`      | `[]`                  |    no    |
| <a name="input_default_capacity_provider_strategy"></a> [default_capacity_provider_strategy](#input_default_capacity_provider_strategy) | Dynamic block for the default capacity provider strategy blcok.               | `list(map(string))` | `[]`                  |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                           | Name of the cluster.                                                          | `string`            | n/a                   |   yes    |
| <a name="input_setting_name"></a> [setting_name](#input_setting_name)                                                                   | Name of the setting to manage. Defaluts to `containerInsights`.               | `string`            | `"containerInsights"` |    no    |
| <a name="input_setting_value"></a> [setting_value](#input_setting_value)                                                                | Value to assign to the setting. Defaults to `enabled`.                        | `string`            | `"enabled"`           |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                           | A mapping of tags to assign to the resource.                                  | `map(string)`       | `{}`                  |    no    |

## Outputs

| Name                                                                 | Description                  |
| -------------------------------------------------------------------- | ---------------------------- |
| <a name="output_ecs_cluster"></a> [ecs_cluster](#output_ecs_cluster) | Amazon ECS Cluster resource. |
