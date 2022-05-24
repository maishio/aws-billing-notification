# --------------------------------------------------------------------------------
# ローカル変数
# --------------------------------------------------------------------------------

locals {
  aws_account_id   = "123456789012"
  aws_region_id    = "ap-northeast-1"
  service          = "example"
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  env              = local.environment_vars.locals.env
}

# --------------------------------------------------------------------------------
# provider.tf テンプレート
# --------------------------------------------------------------------------------

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  allowed_account_ids = ["${local.aws_account_id}"]
  region              = "${local.aws_region_id}"
}
EOF
}

# --------------------------------------------------------------------------------
# backend.tf テンプレート
# --------------------------------------------------------------------------------

remote_state {
  backend = "s3"
  config = {
    bucket  = "aws-billing-notification-tfstate-${local.aws_account_id}"
    encrypt = true
    key     = "tfstate/${local.service}/${local.env}/${basename(get_terragrunt_dir())}.tfstate"
    region  = local.aws_region_id
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# --------------------------------------------------------------------------------
# グローバル変数
# --------------------------------------------------------------------------------

inputs = {
  account = {
    id = local.aws_account_id
  },
  region = {
    id = local.aws_region_id
  },
  tags = {
    env     = local.env
    service = local.service
  }
}