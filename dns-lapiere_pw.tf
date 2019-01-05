# zone
data "aws_route53_zone" "zone_lapiere_pw" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}lapiere.pw"
}

# record lapiere.pw MX
resource "aws_route53_record" "lapiere_pw_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_lapiere_pw.zone_id}"

  name = "lapiere.pw"
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

# record lapiere.pw TXT
resource "aws_route53_record" "lapiere_pw_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_lapiere_pw.zone_id}"

  name = "lapiere.pw"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=GIa17UgWAHDuBNZr8xuJ64rxBPSRyytUo46Zw_uS-dM",
  ]
}
