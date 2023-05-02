# Amazon ECS Service Terraform Resource

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

| Name                                                                                                            | Type     |
| --------------------------------------------------------------------------------------------------------------- | -------- |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |

## Inputs

| Name                                                                                                                                 | Description                                                                                                                        | Type                | Default             | Required |
| ------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ------------------- | :------: |
| <a name="input_assign_public_ip"></a> [assign_public_ip](#input_assign_public_ip)                                                    | Assign a public IP address to the ENI (Fargate launch type only).                                                                  | `bool`              | `false`             |    no    |
| <a name="input_capacity_provider_strategy"></a> [capacity_provider_strategy](#input_capacity_provider_strategy)                      | Dynamic block for the capacity provider strategy.                                                                                  | `list(map(string))` | `[]`                |    no    |
| <a name="input_cluster"></a> [cluster](#input_cluster)                                                                               | ARN of the cluster in which to run the service.                                                                                    | `string`            | n/a                 |   yes    |
| <a name="input_deployment_controller_type"></a> [deployment_controller_type](#input_deployment_controller_type)                      | Type of deployment controller. Defaults to `ECS`.                                                                                  | `string`            | `"ECS"`             |    no    |
| <a name="input_desired_count"></a> [desired_count](#input_desired_count)                                                             | The number of instances of the task definition to place and keep running.                                                          | `number`            | `0`                 |    no    |
| <a name="input_health_check_grace_period_seconds"></a> [health_check_grace_period_seconds](#input_health_check_grace_period_seconds) | Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. | `number`            | `0`                 |    no    |
| <a name="input_launch_type"></a> [launch_type](#input_launch_type)                                                                   | Launch type on which to run your service. The valid values are `EC2`, `FARGATE`, and `EXTERNAL`. Defaults to `EC2`.                | `string`            | `"EC2"`             |    no    |
| <a name="input_load_balancer"></a> [load_balancer](#input_load_balancer)                                                             | Dynamic block for the load balancer.                                                                                               | `list(map(string))` | `[]`                |    no    |
| <a name="input_name"></a> [name](#input_name)                                                                                        | Name of the service.                                                                                                               | `string`            | n/a                 |   yes    |
| <a name="input_propagate_tags"></a> [propagate_tags](#input_propagate_tags)                                                          | Specifies whether to propagate the tags from the task definition or the service to the tasks.                                      | `string`            | `"TASK_DEFINITION"` |    no    |
| <a name="input_security_groups"></a> [security_groups](#input_security_groups)                                                       | List of security group IDs to assign to the ENI.                                                                                   | `list(string)`      | `[]`                |    no    |
| <a name="input_service_registries"></a> [service_registries](#input_service_registries)                                              | Dynamic block for the service registries.                                                                                          | `list(map(string))` | `[]`                |    no    |
| <a name="input_subnets"></a> [subnets](#input_subnets)                                                                               | Subnets associated with the task or service.                                                                                       | `list(string)`      | `[]`                |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                                                        | A mapping of tags to assign to the resource.                                                                                       | `map(string)`       | `{}`                |    no    |
| <a name="input_task_family"></a> [task_family](#input_task_family)                                                                   | Name of the task definition.                                                                                                       | `string`            | n/a                 |   yes    |

## Outputs

| Name                                                                 | Description                  |
| -------------------------------------------------------------------- | ---------------------------- |
| <a name="output_ecs_service"></a> [ecs_service](#output_ecs_service) | Amazon ECS Service resource. |
