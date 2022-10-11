resource "aws_acm_certificate" "omobi" {
  domain_name              = data.aws_route53_zone.omobi.name
  subject_alternative_names = []
  validation_method        = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# 検証結果の確認
resource "aws_acm_certificate_validation" "root" {
  certificate_arn = aws_acm_certificate.omobi.arn
}