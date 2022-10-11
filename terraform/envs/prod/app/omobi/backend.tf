# tfstateの保存の設定
terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "pf/prod/app/omobi_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}