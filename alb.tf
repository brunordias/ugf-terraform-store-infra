## ALB
module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "~> 4.0"

  name        = "${var.name}-alb"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  tags = var.tags
}

resource "aws_lb" "alb" {
  name               = var.name
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets
  security_groups    = [module.alb_sg.security_group_id]
  idle_timeout       = 60

  tags = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Requests otherwise not routed"
      status_code  = "200"
    }
  }
}