# Terragrunt terraform
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#terraform

terraform {
  source = "../../..//modules/lambda"
}

# Terragrunt include
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include

include {
  path = find_in_parent_folders()
}

# Terragrunt dependency
# https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#dependency

dependency "iam" {
  config_path = "../iam"

  mock_outputs = {
    iam_role_arn = "arn:aws:iam::123456789012:role/iam_role_arn"
  }
}

# Terragrunt inputs
# https://terragrunt.gruntwork.io/docs/features/inputs/#inputs

inputs = {
  iam_role_arn = dependency.iam.outputs.iam_role_arn
}
