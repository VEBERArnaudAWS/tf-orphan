# zone
data "aws_route53_zone" "zone_awsworkshop_paris" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}awsworkshop.paris"
}

# record awsworkshop.paris MX
resource "aws_route53_record" "awsworkshop_paris_mx" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_awsworkshop_paris.zone_id}"

  name = "awsworkshop.paris"
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

# record awsworkshop.paris TXT
resource "aws_route53_record" "awsworkshop_paris_txt" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_awsworkshop_paris.zone_id}"

  name = "awsworkshop.paris"
  type = "TXT"
  ttl  = "60"

  records = [
    "google-site-verification=qIK0m1qxflJhS3Ajo2XlPHBg-46CUk-AOUBM7kcy6ts",
  ]
}
