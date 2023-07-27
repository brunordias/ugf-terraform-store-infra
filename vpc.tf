## VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1.0"

  name = var.name
  cidr = "172.29.0.0/16"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = ["172.29.0.0/24", "172.29.1.0/24", "172.29.2.0/24"]
  private_subnets = ["172.29.3.0/24", "172.29.4.0/24", "172.29.5.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = var.tags
}