# クラスターの作成
resource "aws_ecs_cluster" "main" {
  name = "pf-fargate"

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  tags = {
    Name = "pf-fargate"
  }
}
# resource "aws_ecs_cluster" "main" {
#   name = "pf-fargate"
# }


# タスク定義の作成
resource "aws_ecs_task_definition" "task" {
  family                = "pf-fargate"
  container_definitions = file("./container_definitions/service.json")

  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  network_mode       = "awsvpc"
}


# # ECSサービスの作成
resource "aws_ecs_service" "main" {
  name = "pf-fargate"
  cluster = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.task.arn
  platform_version = "1.4.0"
  desired_count                      = 1
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  # launch_type =  "FARGATE"

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 0
    weight            = 1
  }


  load_balancer {
    container_name   = "nginx"
    container_port   = 80
    target_group_arn = aws_lb_target_group.http.arn
  }

  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups = [
      aws_security_group.web.id
    ]
    subnets = [
      aws_subnet.public_1a.id,
      aws_subnet.public_1c.id,
    ]
  }
  enable_execute_command = true

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = {
    Name = "pf-fargate"
  }
}

