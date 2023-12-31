## ECS Fargate
module "ecs_fargate_listener" {
  source  = "brunordias/ecs-fargate/aws"
  version = "~> 8.0.0"

  name                           = "listener"
  ecs_cluster                    = module.ecs_cluster.id
  image_uri                      = "public.ecr.aws/x7i4o2g4/community/listener:latest"
  platform_version               = "1.4.0"
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.private_subnets
  fargate_cpu                    = 256
  fargate_memory                 = 512
  cpu_architecture               = "X86_64"
  ecs_service_desired_count      = 1
  app_port                       = 7070
  load_balancer                  = false
  ecs_service                    = true
  deployment_circuit_breaker     = true
  service_discovery              = true
  service_discovery_namespace_id = aws_service_discovery_private_dns_namespace.local.id
  policies                       = [aws_iam_policy.policy.arn]
  assign_public_ip               = false
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