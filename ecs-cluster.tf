module "ecs_cluster" {
  source  = "brunordias/ecs-cluster/aws"
  version = "~> 2.0.0"

  name               = var.name
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy = {
    capacity_provider = "FARGATE_SPOT"
    weight            = 5
    base              = 1
  }
  container_insights = "disabled"

  tags = var.tags
}