export const AWS_REGION = process.env.AWS_REGION || "us-east-1"
export const CDKTF_BACKEND_BUCKET = process.env.CDKTF_BACKEND_BUCKET || "your-s3-bucket-name"
export const SLACK_WEBHOOK_URL = process.env.SLACK_WEBHOOK_URL || "your-slack-webhook-url"
export const TAGS = {
  service: "aws-billing",
  env: "prod"
}
