# ドメイン所有権の検証方法にDNS検証を選んだ場合、検証用のDNSレコードが必要
# 以下の検証方法は古いやり方
# resource "aws_route53_record" "omobi_certificate" {
#   zone_id = data.aws_route53_zone.omobi.id
#   name    = aws_acm_certificate.omobi.domain_validation_options[0].resource_record_name
#   type    = aws_acm_certificate.omobi.domain_validation_options[0].resource_record_type
#   records = [
#     aws_acm_certificate.omobi.domain_validation_options[0].resource_record_value
#   ]
#   ttl = 60
# }

# 新しいDNS検証方法
# CNAMEをRoute53へ登録
resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.omobi.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  name    = each.value.name
  records = [each.value.record]
  ttl     = 60
  type    = each.value.type
  zone_id = data.aws_route53_zone.omobi.id
}
