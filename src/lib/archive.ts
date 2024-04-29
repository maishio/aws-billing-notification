import { ArchiveProvider } from "@cdktf/provider-archive/lib/provider"
import { Construct } from "constructs"

export const configureArchiveProvider = (scope: Construct): ArchiveProvider => {
  return new ArchiveProvider(scope, "archive")
}
