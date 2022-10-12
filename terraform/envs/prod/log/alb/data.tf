# S3バケットポリシーで使用したデータソースaws_elb_service_accountを宣言
# データソースaws_elb_service_accountを使って、AWSがELB(Elastic Load Balancer)の管理をおこなっているAWSアカウントIDを参照
# AWSのアカウントIDとは異なる
data "aws_elb_service_account" "current" {}