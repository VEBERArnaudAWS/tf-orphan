# zone
data "aws_route53_zone" "zone_haiiku_io" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}haiiku.io"
}

# record haiiku.io MX
resource "aws_route53_record" "haiiku_io_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_haiiku_io.zone_id}"

  name = "haiiku.io"
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

# record haiiku.io TXT
resource "aws_route53_record" "haiiku_io_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_haiiku_io.zone_id}"

  name = "haiiku.io"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=vr5ydIIGYtq9DiLf3bKD_0NZOEbgwthTdeFeR_SXiyc",
  ]
}
