# 自分のAWSアカウントIDの参照
data "aws_caller_identity" "self" {}

data "aws_region" "current" {}