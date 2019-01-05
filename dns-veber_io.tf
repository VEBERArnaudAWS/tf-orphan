# zone
data "aws_route53_zone" "zone_veber_io" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}veber.io"
}

# record veber.io MX
resource "aws_route53_record" "veber_io_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_io.zone_id}"

  name = "veber.io"
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

# record veber.io TXT
resource "aws_route53_record" "veber_io_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_io.zone_id}"

  name = "veber.io"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=8TH7ixeuwjpr4ixml_laKfKrx6EDJQJKOyWcuEK5hO4",
    "keybase-site-verification=U5FFr3HARlVcHu6dXRiC1Z7o6fhAfvJUyYlxYG-Dsmc",
    "v=spf1 include:spf.mandrillapp.com ?all",
  ]
}

# record blog.veber.io cname
resource "aws_route53_record" "blog_veber_io_cname" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_io.zone_id}"

  name    = "blog.veber.io"
  type    = "CNAME"
  ttl     = "60"
  records = ["VEBERArnaud.github.io."]
}
