output "lambda_function_arn" {
  description = "ARN of the Lambda function."
  value       = module.lambda.lambda_function.arn
}
