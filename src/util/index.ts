import * as dotenv from "dotenv"

dotenv.config()

export const AWS_REGION = process.env.AWS_REGION || "us-east-1"
export const CDKTF_BACKEND_BUCKET = process.env.CDKTF_BACKEND_BUCKET || "your-s3-bucket-name"
export const SLACK_WEBHOOK_URL = process.env.SLACK_WEBHOOK_URL || "your-slack-webhook-url"
const ENV = (process.env.ENV as "development" | "staging" | "production") || "development"
const SERVICE = process.env.SERVICE || "aws-billing"

export const tags = {
  env: ENV,
  service: SERVICE
}
