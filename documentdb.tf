## DocumentDB
# KMS
resource "aws_kms_key" "docdb" {
  description             = "KMS key is used by DocumentDB"
  deletion_window_in_days = 7

  tags = var.tags
}

# Cluster
module "documentdb_cluster" {
  source  = "cloudposse/documentdb-cluster/aws"
  version = "0.22.0"

  name                = var.name
  cluster_size        = 1
  master_username     = "admin1"
  master_password     = var.docdb_password
  instance_class      = "db.t4g.medium"
  engine_version      = "4.0.0"
  cluster_family      = "docdb4.0"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnets
  allowed_cidr_blocks = [module.vpc.vpc_cidr_block]
  retention_period    = 7
  storage_encrypted   = true
  kms_key_id          = aws_kms_key.docdb.arn

  tags = var.tags
}

# Secrets Manager
resource "aws_secretsmanager_secret" "docdb" {
  name                           = "docdb_password"
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = true
}

resource "aws_secretsmanager_secret_version" "docdb" {
  secret_id     = aws_secretsmanager_secret.docdb.id
  secret_string = module.documentdb_cluster.master_password
}