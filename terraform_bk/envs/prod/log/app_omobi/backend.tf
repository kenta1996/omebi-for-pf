terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "system/prod/log/app_omobi_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}

