resource "aws_lb_target_group" "http" {
  name     = "pf-http"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    interval            = 30
    path                = "/health_check"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

# resource "aws_lb_target_group" "omobi" {
#   name = "${local.name_prefix}-omobi"

#   deregistration_delay = 60
#   port                 = 80
#   protocol             = "HTTP"
#   target_type          = "ip"
#   vpc_id               = data.terraform_remote_state.network_main.outputs.vpc_this_id
#   health_check {
#     healthy_threshold   = 2
#     interval            = 30
#     matcher             = 200
#     path                = "/"
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     timeout             = 5
#     unhealthy_threshold = 2
#   }

#   tags = {
#     Name = "${local.name_prefix}-omobi"
#   }
# }

# resource "aws_lb_target_group" "omobi" {
#   name = "lb-omobi"

#   deregistration_delay = 60
#   port                 = 80
#   protocol             = "HTTP"
#   target_type          = "ip"
#   vpc_id               = data.terraform_remote_state.network_main.outputs.vpc_this_id
#   health_check {
#     healthy_threshold   = 2
#     interval            = 30
#     matcher             = 200
#     path                = "/"
#     port                = "traffic-port"
#     protocol            = "HTTP"
#     timeout             = 5
#     unhealthy_threshold = 2
#   }

#   tags = {
#     Name = "${local.name_prefix}-omobi"
#   }
# }