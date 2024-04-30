import { CloudwatchEventRule, CloudwatchEventRuleConfig } from "@cdktf/provider-aws/lib/cloudwatch-event-rule"
import { CloudwatchEventTarget } from "@cdktf/provider-aws/lib/cloudwatch-event-target"
import { Construct } from "constructs"

export const createEventBridgeRule = (
  scope: Construct,
  statementPrefix: string,
  config: CloudwatchEventRuleConfig,
  lambdaFunctionArn: string
): { arn: string } => {
  const eventRule = new CloudwatchEventRule(scope, `${statementPrefix}-event-rule`, <CloudwatchEventRuleConfig>{
    description: config.description,
    eventBusName: config.eventBusName || "default",
    eventPattern: config.eventPattern,
    name: config.name,
    scheduleExpression: config.scheduleExpression,
    state: config.state || "DISABLED",
    tags: {
      Name: config.name,
      ...config.tags
    },
    lifecycle: {
      ignoreChanges: ["state"]
    }
  })

  new CloudwatchEventTarget(scope, `${statementPrefix}-event-target`, {
    arn: lambdaFunctionArn,
    rule: eventRule.name
  })

  return { arn: eventRule.arn }
}
