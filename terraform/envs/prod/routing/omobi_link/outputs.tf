# ターゲットグループのARNを参照できるようにする
output "lb_target_group_omobi_arn" {
  value = aws_lb_target_group.omobi.arn
}