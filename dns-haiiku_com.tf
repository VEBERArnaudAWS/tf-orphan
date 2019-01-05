# zone
data "aws_route53_zone" "zone_haiiku_com" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}haiiku.com"
}

# record haiiku.com MX
resource "aws_route53_record" "haiiku_com_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_haiiku_com.zone_id}"

  name = "haiiku.com"
  type = "MX"
  ttl  = "60"

  records = [
    "1 aspmx.l.google.com.",
    "5 alt1.aspmx.l.google.com.",
    "5 alt2.aspmx.l.google.com.",
    "10 aspmx2.googlemail.com.",
    "10 aspmx3.googlemail.com.",
  ]
}

# record haiiku.com TXT
resource "aws_route53_record" "haiiku_com_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_haiiku_com.zone_id}"

  name = "haiiku.com"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=jePsDLxMxiPvg3m-Gk-qLqceKL30GO87mnp5UvMJGn0",
  ]
}
