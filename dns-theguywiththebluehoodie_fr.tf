# zone
data "aws_route53_zone" "zone_theguywiththebluehoodie_fr" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}theguywiththebluehoodie.fr"
}

# record theguywiththebluehoodie.fr MX
resource "aws_route53_record" "theguywiththebluehoodie_fr_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_theguywiththebluehoodie_fr.zone_id}"

  name = "theguywiththebluehoodie.fr"
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

# record theguywiththebluehoodie.fr TXT
resource "aws_route53_record" "theguywiththebluehoodie_fr_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_theguywiththebluehoodie_fr.zone_id}"

  name = "theguywiththebluehoodie.fr"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=U00Lsts4WIDWclDbL1T2n0rX2bnmBQ7-xbCjOQSj8R8",
  ]
}
