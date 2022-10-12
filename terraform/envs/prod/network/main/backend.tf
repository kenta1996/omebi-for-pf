terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "pf/prod/network/main_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}