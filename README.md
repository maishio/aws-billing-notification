# AWS Billing to Slack

This is a terragrutn module that creates an environment for daily notifications of aws billing to your slack.

## Prerequisites

To use the code in this repository, the following software must be installed.

- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://developer.hashicorp.com/terraform/downloads)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Requirements

| Name       | Version   |
| ---------- | --------- |
| terraform  | ~> 1.4.4  |
| terragrunt | >= 0.45.0 |

## Providers

| Name | Version   |
| ---- | --------- |
| aws  | ~> 4.62.0 |

## Set up

### Incoming Webhook in Microsoft Teams

Configure an Incoming Webhook in your Microsoft Teams channel to receive notifications.<br>
Refer to the [guide on setting up Incoming Webhooks in Microsoft Teams](https://learn.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook?tabs=dotnet).

### Create terraform.tfvars

Clone this repository and create `terraform.tfvars` into the `terrafrom/environments/prod` directory.

```bash
git clone https://github.com/maishio/aws-billing-notification.git
touch aws-billing-notification/terrafrom/environments/prod/terraform.tfvars
```

### Edit terraform.tfvars

Edit the `terraform.tfvars` file and add the following variables.

```terraform
teams_webhook_url = "https://xxxxxxx.outlook.office.com/webhookb2/xxxxxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx@xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/IncomingWebhook/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

### Edit env.hcl

Modify the values of local variables in `aws-billing-notification/terrafrom/environments/prod/env.hcl` to suit your environment.

```terraform
locals {
  aws_account_id = "123456789012"
  aws_region_id  = "us-east-1"
  env            = "myEnv"
  service        = "myService"
}
```

## Execute terraform

Initialize terraform and display the plan.

```bash
cd aws-billing-notification/terrafrom/environments/prod
terragrunt run-all init --terragrunt-non-interactive
terragrunt run-all plan
```

Apply the plan.

```bash
terragrunt run-all apply
```

## Destroy the resources

destroy the resources.

```bash
cd aws-billing-notification/terrafrom/environments/prod
terragrunt run-all destroy
```

## Change the Lambda function execution time

Change the value of the `schedule_expression` attribute in `aws-billing-notification/modules/lambda/cloudwatch_event.tf`.<br>
After changing `schedule_expression`, rerun `terragrunt run-all plan` and `terragrunt run-all apply`.

```
schedule_expression = "cron(0 0 * * ? *)"
```
