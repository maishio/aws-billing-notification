# AWS Billing Notification Lambda Function

## 概要

AWS利用料金をTeamsに日次で通知するLambda関数を構築するTerraform

## Requirements

|Name|Version|
|----|-------|
|terraform|~> 1.1.19|
|terragrunt|~> 0.37.1|

## Providers

|Name|Version|
|----|-------|
|aws|~> 4.15.0|

## 環境構築

- [環境構築手順](docs/README.md)

## Microsoft Teams受信Webhookの準備

1. [受信Webhookを作成する](https://docs.microsoft.com/ja-jp/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook)を参照してMicrosoft Teamsの受信Webhookを作成ください。    
  
2. /path/to/aws-billing-notification/modules/lambda/terraform.tfvarsを追加します。

```
% touch /path/to/aws-billing-notification/modules/lambda/terraform.tfvars
```

3. terraform.tfvarsに以下を追記して保存します。  

```
TEAMS_WEBHOOK_URL = "{Teamsの受信Webhook URL}"
```
  
※ {Teamsの受信Webhook URL}部分は環境に合わせて適宜変更ください。


### /path/to/aws-billing-notification/terraform/terragrunt.hclの編集

terragrunt.hclのローカル変数の値を環境に合わせて修正ください。

```
# --------------------------------------------------------------------------------
# ローカル変数
# --------------------------------------------------------------------------------

locals {
  aws_account_id   = 123456789012"        # AWSリソースを作成するAWSアカウントID
  aws_region_id    = "ap-northeast-1"     # AWSリソースを作成するリージョン
  service          = "example"            # AWSリソースに設定するserviceタグの値
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.env
}
```

## Terragruntの実行

### AWSリソースを作成する

```
% cd /path/to/aws-billing-notification/terraform/environments/prod
% terragrunt run-all init --terragrunt-non-interactive
% terragrunt run-all plan
% terragrunt run-all apply
```

### tfstateで管理されているAWSリソースを一覧を表示する

```
% cd /path/to/aws-billing-notification/terraform/environments/prod
% terraform state list
```

### AWSリソースを削除する

```
% cd /path/to/aws-billing-notification/terraform/environments/prod
% terragrunt run-all destroy
```

## Lambda関数の起動時間を変更する手順

/path/to/aws-billing-notification/modules/lambda/cloudwatch_event.tfのschedule_expression属性の値を変更します。

```
schedule_expression = "cron(0 0 * * ? *)"
```

※ 属性値を変更後は、terragrunt run-all plan、terragrunt run-all applyを再実行して変更を反映すること
