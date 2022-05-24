# --------------------------------------------------------------------------------
# Terragrunt terraform ブロック
# @see https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#terraform
# --------------------------------------------------------------------------------

terraform {
  source = "../../../modules/lambda"
}

# --------------------------------------------------------------------------------
# Terragrunt include ブロック
# @see https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include
# --------------------------------------------------------------------------------

include {
  path = find_in_parent_folders()
}
