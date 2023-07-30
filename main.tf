provider "aws" {
  region = var.region
}

data "aws_route53_zone" "this" {
  name = var.route53_domain
}