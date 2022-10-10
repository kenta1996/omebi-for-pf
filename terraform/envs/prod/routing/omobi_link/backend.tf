terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "system/prod/routing/omobi_link_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}