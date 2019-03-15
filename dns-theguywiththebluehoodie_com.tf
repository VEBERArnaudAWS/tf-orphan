# zone
data "aws_route53_zone" "zone_theguywiththebluehoodie_com" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}theguywiththebluehoodie.com"
}

# record theguywiththebluehoodie.com MX
resource "aws_route53_record" "theguywiththebluehoodie_com_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_theguywiththebluehoodie_com.zone_id}"

  name = "theguywiththebluehoodie.com"
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

# record theguywiththebluehoodie.com TXT
resource "aws_route53_record" "theguywiththebluehoodie_com_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_theguywiththebluehoodie_com.zone_id}"

  name = "theguywiththebluehoodie.com"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=38TXAzcMvxNw_vzYxyigpH9LIIi6RhSOpOObHeQd4eI",
  ]
}
