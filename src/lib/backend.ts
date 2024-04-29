import { S3Backend } from "cdktf"
import { Construct } from "constructs"

export const configureS3Backend = (scope: Construct): S3Backend => {
  return new S3Backend(scope, {
    bucket: "<existing-s3-bucket-name>",
    key: `tfstate/${scope.node.id}.tfstate`,
    region: "us-east-1",
    acl: "bucket-owner-full-control"
  })
}
