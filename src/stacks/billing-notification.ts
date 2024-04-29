import { DataAwsIamPolicyDocument } from "@cdktf/provider-aws/lib/data-aws-iam-policy-document"
import { TerraformStack } from "cdktf"
import { Construct } from "constructs"

import { TAGS } from "../../config"
import {
  configureArchiveProvider,
  configureAwsProvider,
  configureS3Backend,
  createIamRole,
  createTrustPolicyDocument
} from "../lib"

export class BillingNotificationStack extends TerraformStack {
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
      tags: TAGS
    }

    const iamPolicyConfig = {
      name: "aws-billing-to-slack-policy",
      policy: policy,
      tags: TAGS
    }

    createIamRole(this, "aws-billing-to-slack", iamRoleConfig, iamPolicyConfig)
  }
}
