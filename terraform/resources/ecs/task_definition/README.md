# Amazon ECS Task Definition Terraform Resource

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

| Name                                                                                                                            | Type     |
| ------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |

## Inputs

| Name                                                                                                      | Description                                                                                          | Type           | Default                         | Required |
| --------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | -------------- | ------------------------------- | :------: |
| <a name="input_cpu"></a> [cpu](#input_cpu)                                                                | The number of cpu units used by the task.                                                            | `string`       | `"256"`                         |    no    |
| <a name="input_execution_role_arn"></a> [execution_role_arn](#input_execution_role_arn)                   | ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume. | `string`       | `null`                          |    no    |
| <a name="input_family"></a> [family](#input_family)                                                       | A unique name for your task definition.                                                              | `string`       | n/a                             |   yes    |
| <a name="input_memory"></a> [memory](#input_memory)                                                       | Amount (in MiB) of memory used by the task.                                                          | `string`       | `"512"`                         |    no    |
| <a name="input_network_mode"></a> [network_mode](#input_network_mode)                                     | Docker networking mode to use for the containers in the task.                                        | `string`       | `"awsvpc"`                      |    no    |
| <a name="input_path"></a> [path](#input_path)                                                             | Path to the task definition template.                                                                | `string`       | `null`                          |    no    |
| <a name="input_requires_compatibilities"></a> [requires_compatibilities](#input_requires_compatibilities) | Set of launch types required by the task. Valid values are `EC2` and `FARGATE`.                      | `list(string)` | <pre>[<br> "FARGATE"<br>]</pre> |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                             | A mapping of tags to assign to the resource.                                                         | `map(string)`  | `{}`                            |    no    |
| <a name="input_task_role_arn"></a> [task_role_arn](#input_task_role_arn)                                  | ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services.      | `string`       | `null`                          |    no    |
| <a name="input_vars"></a> [vars](#input_vars)                                                             | Variables to pass to the task definition template.                                                   | `map(string)`  | `{}`                            |    no    |
| <a name="input_volume"></a> [volume](#input_volume)                                                       | Dynamic block for the volume.                                                                        | `any`          | `[]`                            |    no    |

## Outputs

| Name                                                                                         | Description |
| -------------------------------------------------------------------------------------------- | ----------- |
| <a name="output_ecs_task_definition"></a> [ecs_task_definition](#output_ecs_task_definition) | n/a         |
