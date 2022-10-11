terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "terraform-pf/vpc/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"
}