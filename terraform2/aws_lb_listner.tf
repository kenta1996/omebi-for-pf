# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#       target_group_arn = aws_lb_target_group.http.arn
#       type             = "forward"
#   }
#   # default_action {
#   #   type = "fixed-response"

#   #   fixed_response {

#   #     content_type = "text/plain"
#   #     message_body = "test1"
#   #     status_code = "200"
#   #   }
#   # }
# }

resource "aws_lb_listener" "https" {
  certificate_arn   = aws_acm_certificate.omobi.arn
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  # default_action {
  #   type = "forward"
  #   target_group_arn = aws_lb_target_group.http.arn
  # }
    # default_action {
    #   type = "fixed-response"
    #   fixed_response {
    #     content_type = "text/plain"
    #     message_body = "test1"
    #     status_code = "200"
    #   }
    # }
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.http.arn
    }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}