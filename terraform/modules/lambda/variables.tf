# --------------------------------------------------------------------------------
# 属性定義
# --------------------------------------------------------------------------------

variable "account" {
  type = map(string)
}

variable "region" {
  type = map(string)
}

variable "tags" {
  type = map(string)
}

variable "TEAMS_WEBHOOK_URL" {
  type = string
}
