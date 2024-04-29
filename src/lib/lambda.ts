import { DataArchiveFile, DataArchiveFileConfig } from "@cdktf/provider-archive/lib/data-archive-file"
import { CloudwatchLogGroup, CloudwatchLogGroupConfig } from "@cdktf/provider-aws/lib/cloudwatch-log-group"
import { LambdaFunction, LambdaFunctionConfig } from "@cdktf/provider-aws/lib/lambda-function"
import { LambdaPermission, LambdaPermissionConfig } from "@cdktf/provider-aws/lib/lambda-permission"
import { Construct } from "constructs"

export const createClodWatchLogGroup = (
  scope: Construct,
  statementPrefix: string,
  config: CloudwatchLogGroupConfig
): CloudwatchLogGroup => {
  return new CloudwatchLogGroup(scope, `${statementPrefix}-log-group`, <CloudwatchLogGroupConfig>{
    name: config.name,
    retentionInDays: config.retentionInDays,
    tags: {
      Name: config.name,
      ...config.tags
    }
  })
}

export const createLambdaFunction = (
  scope: Construct,
  statementPrefix: string,
  archiveFileConfig: DataArchiveFileConfig,
  lambdaFunctionConfig: LambdaFunctionConfig
): { arn: string; functionName: string } => {
  const archiveFile = new DataArchiveFile(scope, `${statementPrefix}-archive-file`, {
    type: archiveFileConfig.type,
    outputPath: archiveFileConfig.outputPath,
    sourceDir: archiveFileConfig.sourceDir
  })

  const lambdaFunction = new LambdaFunction(scope, `${statementPrefix}-lambda-function`, {
    architectures: lambdaFunctionConfig.architectures || ["x86_64"],
    environment: lambdaFunctionConfig.environment,
    filename: archiveFile.outputPath,
    functionName: lambdaFunctionConfig.functionName,
    handler: lambdaFunctionConfig.handler,
    memorySize: lambdaFunctionConfig.memorySize || 128,
    packageType: lambdaFunctionConfig.packageType || "Zip",
    role: lambdaFunctionConfig.role,
    runtime: lambdaFunctionConfig.runtime,
    sourceCodeHash: archiveFile.outputBase64Sha256,
    tags: {
      Name: lambdaFunctionConfig.functionName,
      ...lambdaFunctionConfig.tags
    },
    timeout: lambdaFunctionConfig.timeout || 180
  })

  return { arn: lambdaFunction.arn, functionName: lambdaFunction.functionName }
}

export const CreateLambdaPermission = (
  scope: Construct,
  statementPrefix: string,
  config: LambdaPermissionConfig
): void => {
  new LambdaPermission(scope, `${statementPrefix}-lambda-permission`, {
    action: config.action,
    functionName: config.functionName,
    principal: config.principal,
    sourceArn: config.sourceArn
  })
}
