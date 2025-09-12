resource "aws_route53_zone" "zone" {
  name = var.domain_name
}

resource "aws_route53_record" "strapi_record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = "strapi"
  type    = "A"
  ttl     = 300
  records = [aws_instance.strapi_ec2.public_ip]
}
