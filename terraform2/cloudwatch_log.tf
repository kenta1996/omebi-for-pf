resource "aws_cloudwatch_log_group" "nginx" {
  name = "/ecs/pf/nginx"

  retention_in_days = 90
}

resource "aws_cloudwatch_log_group" "php" {
  name = "/ecs/pf/php"

  retention_in_days = 90
}
