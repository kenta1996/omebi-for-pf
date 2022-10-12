# ターゲットグループのARNを参照できるように
output "lb_target_group_omobi_arn" {
  value = aws_lb_target_group.omobi.arn
}