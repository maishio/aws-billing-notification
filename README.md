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

## Architecture

<div align="center">
  <img src="https://user-images.githubusercontent.com/44653717/236378612-fff9ab87-1667-4cbc-81c2-90090651e2db.png" />
</div>

## Preparations

1. Log in to your AWS account using the AWS CLI:

```bash
aws configure
```

2. Create an [incoming webhook](https://www.slack.com/apps/new/A0F7XDUAZ) that will post to the channel of your choice on your Slack workspace. Grab the URL for use in the next step.

3. Clone this repository and create `terraform.tfvars` into the `terrafrom/environments/prod/lambda` directory:

```bash
git clone https://github.com/maishio/aws-billing-to-slack.git
touch aws-billing-to-slack/terrafrom/environments/prod/lambda/terraform.tfvars
```

4. Edit the `terraform.tfvars` file and add the following variables:

```hcl
slack_webhook_url = "https://hooks.slack.com/services/xxxxxxxxx/xxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxx"
```

5. Modify the values of local variables in [env.hcl](terraform/environments/prod/env.hcl) to suit your environment.

```hcl
locals {
  aws_account_id = "123456789012"
  aws_region_id  = "us-east-1"
  env            = "myEnv"
  service        = "myService"
}
```

## Deploy the resources

1. Initialize the Terraform working directory:

```bash
cd aws-billing-to-slack/terrafrom/environments/prod
terragrunt run-all init --terragrunt-non-interactive
```

2. plan the Terraform configuration:

```bash
terragrunt run-all plan
```

3. Apply the Terraform configuration:

```bash
terragrunt run-all apply
```

## Destroy the resources

destroy the resources.

```bash
cd aws-billing-to-slack/terrafrom/environments/prod
terragrunt run-all destroy
```

## Change the Lambda function execution time

Change the value of the `schedule_expression` attribute in `terraform/modules/lambda/eventbridge.tf`.<br>
After changing `schedule_expression`, rerun `terragrunt run-all plan` and `terragrunt run-all apply`.

```
schedule_expression = "cron(0 0 * * ? *)"
```

## Modules

- [lambda](terraform/modules/lambda/README.md)
