# zone
data "aws_route53_zone" "zone_theguywiththebluehoodie_net" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}theguywiththebluehoodie.net"
}

# record theguywiththebluehoodie.net MX
resource "aws_route53_record" "theguywiththebluehoodie_net_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_theguywiththebluehoodie_net.zone_id}"

  name = "theguywiththebluehoodie.net"
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

# record theguywiththebluehoodie.net TXT
resource "aws_route53_record" "theguywiththebluehoodie_net_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_theguywiththebluehoodie_net.zone_id}"

  name = "theguywiththebluehoodie.net"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=LRlljy6VkCgUT6DkVjAy-pgvvFRrTgXDYtLENv0V_DI",
  ]
}
