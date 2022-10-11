# Dockerイメージをコンテナレジストリに登録
# {システム名}-{環境名}-{サービス名}に相当するプレフィックスをつける
resource "aws_ecr_repository" "this" {
  name = var.name

  tags = {
    Name = var.name
  }
}

# ライフサイクルポリシーの設定
# 最新の10個までイメージを残し、それより古いものは自動削除
resource "aws_ecr_lifecycle_policy" "this" {
  policy = jsonencode(
    {
      "rules": [
        {
          "rulePriority": 1,
          "description": "Hold only ${var.holding_count} images, expire all others",
          "selection": {
            "tagStatus": "any",
            "countType": "imageCountMoreThan",
            "countNumber": var.holding_count
          },
          "action": {
            "type": "expire"
          }
        }
      ]
    }
  )

  repository = aws_ecr_repository.this.name
}