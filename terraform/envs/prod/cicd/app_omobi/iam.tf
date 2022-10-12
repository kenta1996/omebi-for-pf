# cicd用のiamユーザの作成
resource "aws_iam_user" "github" {
  name = "${local.name_prefix}-${local.service_name}-github"

  tags = {
    Name = "${local.name_prefix}-${local.service_name}-github"
  }
}

# IAMロールの作成
resource "aws_iam_role" "deployer" {
  name = "${local.name_prefix}-${local.service_name}-deployer"

  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "sts:AssumeRole",
            "sts:TagSession"
          ],
          "Principal" : {
            "AWS" : aws_iam_user.github.arn
          }
        }
      ]
    }
  )

  tags = {
    Name = "${local.name_prefix}-${local.service_name}-deployer"
  }
}

# IAMロールへのAWS管理ポリシー付与
data "aws_iam_policy" "ecr_power_user" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# dataはディレクトリのtfstateでは管理していないリソースを参照する
# AmazonEC2ContainerRegistryPowerUserを参照
resource "aws_iam_role_policy_attachment" "role_deployer_policy_ecr_power_user" {
  role       = aws_iam_role.deployer.name
  policy_arn = data.aws_iam_policy.ecr_power_user.arn
}



# S3読み取り権限追加
resource "aws_iam_role_policy" "s3" {
  name = "s3"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:GetObject"
          ],
          "Resource" : "arn:aws:s3:::omobi-tfstate/${local.system_name}/${local.env_name}/cicd/app_${local.service_name}_*.tfstate"
        },
      ]
    }
  )
}


# ECSデプロイ権限の追加
resource "aws_iam_role_policy" "ecs" {
  name = "ecs"
  role = aws_iam_role.deployer.id

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "RegisterTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "ecs:RegisterTaskDefinition"
          ],
          "Resource" : "*"
        },
        {
          "Sid" : "PassRolesInTaskDefinition",
          "Effect" : "Allow",
          "Action" : [
            "iam:PassRole"
          ],
          "Resource" : [
            data.aws_iam_role.ecs_task_execution.arn,
          ]
        },
        {
          "Sid" : "DeployService",
          "Effect" : "Allow",
          "Action" : [
            "ecs:UpdateService",
            "ecs:DescribeServices"
          ],
          "Resource" : [
            data.aws_ecs_service.this.arn
          ]
        }
      ]
    }
  )
}