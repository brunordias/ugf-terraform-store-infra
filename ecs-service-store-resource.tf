## ECS Fargate
module "ecs_fargate_store_resource" {
  source  = "brunordias/ecs-fargate/aws"
  version = "~> 8.0.0"

  name                           = "store-resource"
  ecs_cluster                    = module.ecs_cluster.id
  image_uri                      = "public.ecr.aws/x7i4o2g4/community/store-resource:latest"
  platform_version               = "1.4.0"
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  fargate_cpu                    = 256
  fargate_memory                 = 512
  cpu_architecture               = "X86_64"
  ecs_service_desired_count      = 1
  app_port                       = 8080
  load_balancer                  = true
  ecs_service                    = true
  deployment_circuit_breaker     = true
  service_discovery              = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.local.id
  policies                       = [aws_iam_policy.policy.arn]
  lb_listener_arn = [
    aws_lb_listener.http.arn
  ]
  lb_host_header = [aws_lb.alb.dns_name]
  lb_arn_suffix  = aws_lb.alb.arn_suffix
  health_check = {
    enabled             = true
    healthy_threshold   = 2
    interval            = 30
    matcher             = "200"
    path                = "/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 10
  }
  capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = 1
      base              = 0
    }
  ]
  app_environment = []
  autoscaling     = true
  autoscaling_settings = {
    max_capacity        = 10
    min_capacity        = 1
    target_cpu_value    = 65
    target_memory_value = 65
    scale_in_cooldown   = 300
    scale_out_cooldown  = 300
  }

  tags = var.tags
}