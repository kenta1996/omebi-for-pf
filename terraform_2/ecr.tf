resource "aws_ecr_repository" "nginx" {
  name = "pf-nginx"

  tags = {
    Name = "pf-nginx"
  }
}

resource "aws_ecr_lifecycle_policy" "nginx" {
  policy = jsonencode(
    {
      "rules": [
        {
          "rulePriority": 1,
          "description": "Hold only 10 images, expire all others",
          "selection": {
            "tagStatus": "any",
            "countType": "imageCountMoreThan",
            "countNumber": 10
          },
          "action": {
            "type": "expire"
          }
        }
      ]
    }
  )
  repository = aws_ecr_repository.nginx.name
}

resource "aws_ecr_repository" "laravel" {
  name = "pf-laravel"

  tags = {
    Name = "pf-laravel"
  }
}

resource "aws_ecr_lifecycle_policy" "laravel" {
  policy = jsonencode(
    {
      "rules": [
        {
          "rulePriority": 1,
          "description": "Hold only 10 images, expire all others",
          "selection": {
            "tagStatus": "any",
            "countType": "imageCountMoreThan",
            "countNumber": 10
          },
          "action": {
            "type": "expire"
          }
        }
      ]
    }
  )
  repository = aws_ecr_repository.laravel.name
}