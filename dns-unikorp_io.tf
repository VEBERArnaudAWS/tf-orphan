# zone
data "aws_route53_zone" "zone_unikorp_io" {
  name = "${lookup(var.env_dns_zones_prefix, terraform.workspace)}unikorp.io"
}

# record docs.unikorp.io cname
resource "aws_route53_record" "docs_unikorp_io_a" {
  count = "${terraform.workspace == "prd" ? 1 : 0}"

  zone_id = "${data.aws_route53_zone.zone_unikorp_io.zone_id}"

  name = "docs.unikorp.io"
  type = "A"

  alias {
    name                   = "s3-website.eu-west-2.amazonaws.com"
    zone_id                = "Z3GKZC51ZF0DB4"
    evaluate_target_health = "false"
  }
}
