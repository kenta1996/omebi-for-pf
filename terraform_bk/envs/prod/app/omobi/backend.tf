# インフラの最新状態をtfstateというファイルで管理する
# チーム開発の際に、ローカルではなく全員が参照変更できる場所に保存する必要があるので、今回はS3保存
# システム名/laravel-fargate-infraリポジトリにおけるenvs以下のパス_Terraformバージョン名.tfstate
# システム名：system
terraform {
  backend "s3" {
    bucket = "omobi-tfstate"
    key    = "system/prod/app/omobi_v1.2.8.tfstate"
    region = "ap-northeast-1"
  }
}