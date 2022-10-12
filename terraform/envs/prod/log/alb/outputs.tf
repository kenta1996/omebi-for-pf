# ALB作成時にS3のバケットIDが必要のため
# 別ディレクトリで参照するため
output "s3_bucket_this_id" {
  value = aws_s3_bucket.this.id
}