# タスク定義には、各コンテナがイメージをプルしてくるコンテナレジストリのURIを設定する必要がある
# ECRをTerraformのモジュールとして作成してるので、モジュールのoutputとしてECRのURIを追加し、モジュールの呼び出し元から参照できるようにする
output "ecr_repository_this_repository_url" {
  value = aws_ecr_repository.this.repository_url
}