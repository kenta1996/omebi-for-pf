terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "system/prod/log/alb_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}