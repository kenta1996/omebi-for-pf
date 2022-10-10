data "aws_caller_identity" "self" {}

data "aws_region" "current" {}

data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "omobi-tfstate"
    key    = "${local.system_name}/${local.env_name}/network/main_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "routing_omobi_link" {
  backend = "s3"
  config = {
    bucket = "omobi-tfstate"
    key    = "${local.system_name}/${local.env_name}/routing/omobi_link_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}