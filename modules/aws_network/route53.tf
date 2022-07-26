resource "aws_route53_record" "cube" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "cube.${var.route53_domain_name}"
  type            = "A"
  ttl             = "60"
  records         = ["192.168.1.4"]
}
resource "aws_route53_record" "home" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "hypercube.${var.route53_domain_name}"
  type            = "A"
  ttl             = "60"
  records         = ["127.0.0.1"]
}

resource "aws_route53_record" "hypercube" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "hypercube.${var.route53_domain_name}"
  type            = "A"
  ttl             = "60"
  records         = ["192.168.1.5"]
}

resource "aws_route53_record" "horizon" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "horizon.${var.route53_domain_name}"
  type            = "A"
  ttl             = "60"
  records         = ["192.168.1.6"]
}

resource "aws_route53_record" "alluvium-cloud" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "${var.route53_domain_name}"
  type            = "A"
  ttl             = "3600"
  records         = ["76.76.21.21"]
}
resource "aws_route53_record" "www-alluvium-cloud" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "www.${var.route53_domain_name}"
  type            = "CNAME"
  ttl             = "3600"
  records         = ["cname.vercel-dns.com."]
}

resource "aws_route53_record" "dev-alluvium-cloud" {
  allow_overwrite = true
  zone_id         = var.route53_hosted_zone_id
  name            = "dev.${var.route53_domain_name}"
  type            = "CNAME"
  ttl             = "3600"
  records         = ["cname.vercel-dns.com."]
}
