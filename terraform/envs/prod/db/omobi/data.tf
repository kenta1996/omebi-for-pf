data "aws_kms_alias" "rds" {
  name = "alias/aws/rds"
}

data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "omobi-tfstate"
    key    = "${local.system_name}/${local.env_name}/network/main_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}