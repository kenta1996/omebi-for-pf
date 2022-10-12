# ECSのタスク実行権限
# SSMのread権限
# S3読み取り権限
resource "aws_iam_role" "ecs_task_execution" {
  name = "${local.name_prefix}-${local.service_name}-ecs-task-execution"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ecs-tasks.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ]
}

