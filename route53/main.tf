resource "aws_route53_zone" "nonprod-private" {
  name = "pod7.com"
  vpc {
    vpc_id = var.nonprod_vpc_id
  }
}
resource "aws_route53_record" "nonprod-database" {
  zone_id = aws_route53_zone.nonprod-private.zone_id
  name = "db"
  type = "CNAME"
  ttl = 300
  records = [var.rds_endpoint]
}
resource "aws_route53_zone" "prod-private" {
  name = "pod7.com"
  vpc {
    vpc_id = var.prod_vpc_id
  }
}
resource "aws_route53_record" "prod-database" {
  zone_id = aws_route53_zone.prod-private.zone_id
  name = "db"
  type = "CNAME"
  ttl = 300
  records = [var.rds_endpoint_prod]
}