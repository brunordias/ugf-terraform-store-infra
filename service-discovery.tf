## Service Discovery
resource "aws_service_discovery_private_dns_namespace" "local" {
  name        = "services.local"
  description = "local"
  vpc         = module.vpc.vpc_id

  tags = var.tags
}

resource "aws_service_discovery_service" "local" {
  name = "local"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.local.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }

  tags = var.tags
}