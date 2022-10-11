data "aws_route53_zone" "omobi" {
  name = "omobi.link"
}

# すでに作成していたALBと関連づける
resource "aws_route53_record" "omobi" {
  zone_id = data.aws_route53_zone.omobi.zone_id
  name    = data.aws_route53_zone.omobi.name
  type    = "A"

  alias {
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
    evaluate_target_health = true
  }
}