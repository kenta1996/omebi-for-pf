terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "pf/prod/db/omobi_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}