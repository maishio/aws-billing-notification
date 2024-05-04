import * as path from "path"

import { DataAwsIamPolicyDocument } from "@cdktf/provider-aws/lib/data-aws-iam-policy-document"
import { TerraformStack } from "cdktf"
import { Construct } from "constructs"

import {
  configureArchiveProvider,
  configureAwsProvider,
  configureS3Backend,
  createEventBridgeRule,
  createIamRole,
  createLambdaFunction,
  createLambdaPermission,
  createTrustPolicyDocument
} from "../lib"
import { SLACK_WEBHOOK_URL, tags } from "../util"

export class LambdaStack extends TerraformStack {
  constructor(scope: Construct, name: string) {
    super(scope, name)

    configureAwsProvider(this)
    configureArchiveProvider(this)
    configureS3Backend(this)

    const assumeRolePolicy = createTrustPolicyDocument(this, "aws-billing-to-slack", "lambda.amazonaws.com")

    const policy = new DataAwsIamPolicyDocument(this, "aws-billing-to-slack-policy-document", {
      statement: [
        {
          actions: ["ce:GetCostAndUsage", "logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
          effect: "Allow",
          resources: ["*"]
        }
      ]
    }).json

    const iamRoleConfig = {
      assumeRolePolicy: assumeRolePolicy,
      name: "aws-billing-to-slack-role",
      tags: tags
    }

    const iamPolicyConfig = {
      name: "aws-billing-to-slack-policy",
      policy: policy,
      tags: tags
    }

    const functionRole = createIamRole(this, "aws-billing-to-slack", iamRoleConfig, iamPolicyConfig)

    const archiveFileConfig = {
      type: "zip",
      outputPath: path.join(__dirname, "../assets/billing-notifier/output/function.zip"),
      sourceDir: path.join(__dirname, "../assets/billing-notifier/target/lambda/billing-notifier")
    }

    const lambdaFunctionConfig = {
      description: "AWS billing notification function",
      functionName: "aws-billing-to-slack",
      handler: "bootstrap",
      role: functionRole.arn,
      runtime: "provided.al2",
      tags: tags,
      environment: {
        variables: {
          SLACK_WEBHOOK_URL: SLACK_WEBHOOK_URL
        }
      }
    }

    const lambdaFunction = createLambdaFunction(this, "aws-billing-to-slack", archiveFileConfig, lambdaFunctionConfig)

    const eventBridgeRuleConfig = {
      description: "AWS billing notification rule",
      name: "aws-billing-to-slack-rule",
      scheduleExpression: "cron(0 0 * * ? *)",
      state: "ENABLED",
      tags: tags
    }

    const eventRule = createEventBridgeRule(this, "aws-billing-to-slack", eventBridgeRuleConfig, lambdaFunction.arn)

    const lambdaPermissionConfig = {
      action: "lambda:InvokeFunction",
      functionName: lambdaFunction.functionName,
      principal: "events.amazonaws.com",
      sourceArn: eventRule.arn
    }

    createLambdaPermission(this, "aws-billing-to-slack", lambdaPermissionConfig)
  }
}
