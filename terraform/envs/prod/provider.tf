# シンボリックリックを作成して、他のディレクトリでも読み込ませる
# AWSプロバイダーを使用することを宣言
provider "aws" {
  region = "ap-northeast-1"
  # 一括してタグ付する用
  default_tags {
    tags = {
      Env    = "prod"
      System = "pf"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
  }
  required_version = "1.2.8"
}