# zone
data "aws_route53_zone" "zone_veber_pw" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}veber.pw"
}

# record veber.pw MX
resource "aws_route53_record" "veber_pw_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_pw.zone_id}"

  name = "veber.pw"
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

# record veber.pw TXT
resource "aws_route53_record" "veber_pw_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_pw.zone_id}"

  name = "veber.pw"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=OnWETQE7reE7bpiZVaAlM5rLm0BOE7nilOJt1A65fgI",
    "keybase-site-verification=BP567hsL44WIPWe7DHHJyKbGzNhs-HTqthbrs86oOsA",
    "v=spf1 include:_spf.google.com ~all",
  ]
}

# record calendar.veber.pw cname
resource "aws_route53_record" "calendar_veber_pw_cname" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_pw.zone_id}"

  name    = "calendar.veber.pw"
  type    = "CNAME"
  ttl     = "60"
  records = ["ghs.googlehosted.com."]
}

# record drive.veber.pw cname
resource "aws_route53_record" "drive_veber_pw_cname" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_pw.zone_id}"

  name    = "drive.veber.pw"
  type    = "CNAME"
  ttl     = "60"
  records = ["ghs.googlehosted.com."]
}

# record mail.veber.pw cname
resource "aws_route53_record" "mail_veber_pw_cname" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_veber_pw.zone_id}"

  name    = "mail.veber.pw"
  type    = "CNAME"
  ttl     = "60"
  records = ["ghs.googlehosted.com."]
}
