## ACM
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.3.0"

  domain_name = var.api_url
  zone_id     = data.aws_route53_zone.this.zone_id

  wait_for_validation = true

  tags = var.tags
}