resource "aws_lb" "lb" {
  name               = "pf-lb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.web.id,
  ]

  subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_1c.id,
  ]
}