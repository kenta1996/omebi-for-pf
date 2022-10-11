terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "pf/prod/cicd/app_omobi_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}