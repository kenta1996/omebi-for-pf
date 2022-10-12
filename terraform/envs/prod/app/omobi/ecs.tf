# クラスターの作成
resource "aws_ecs_cluster" "this" {
  name = "${local.name_prefix}-${local.service_name}"

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  tags = {
    Name = "${local.name_prefix}-${local.service_name}"
  }
}

# タスク定義の作成
resource "aws_ecs_task_definition" "this" {
  family = "${local.name_prefix}-${local.service_name}"

  task_role_arn = aws_iam_role.ecs_task_execution.arn
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  network_mode       = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  container_definitions = file("./container_definitions/service.json")
}

# サービスの作成
resource "aws_ecs_service" "this" {
  name = "${local.name_prefix}-${local.service_name}"

  cluster = aws_ecs_cluster.this.arn

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = 0
    weight            = 1
  }

  platform_version = "1.4.0"

  task_definition = aws_ecs_task_definition.this.arn

  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  load_balancer {
    container_name   = "nginx"
    container_port   = 80
    target_group_arn = data.terraform_remote_state.routing_appomobi_link.outputs.lb_target_group_omobi_arn
  }

  # ヘルスチェックの猶予期間
  health_check_grace_period_seconds = 120

  network_configuration {
    assign_public_ip = true
    # publicと紐づける
    security_groups = [
      data.terraform_remote_state.network_main.outputs.security_group_web_id
    ]
    subnets = [
      for s in data.terraform_remote_state.network_main.outputs.subnet_public : s.id
    ]
  }

  enable_execute_command = true

  tags = {
    Name = "${local.name_prefix}-${local.service_name}"
  }
}