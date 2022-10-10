data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "omobi-tfstate"
    key    = "${local.system_name}/${local.env_name}/network/main_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "log_alb" {
  backend = "s3"

  config = {
    bucket = "omobi-tfstate"
    key    = "${local.system_name}/${local.env_name}/log/alb_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}