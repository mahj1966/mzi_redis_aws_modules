module "elasticache" {
  source  = "terraform-aws-modules/elasticache/aws"

  cluster_id               = var.cluster_id
  create_cluster           = var.cluster_mode == "disabled"
  create_replication_group = var.cluster_mode == "enabled"

  engine          = "redis"
  engine_version  = var.engine_version
  node_type       = var.node_type
  num_cache_nodes = var.num_cache_nodes

  subnet_ids = var.subnet_ids

  vpc_id            = var.vpc_id
  security_group_ids = var.security_group_ids

  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window

  parameter_group_name = var.parameter_group_name

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  auth_token                 = var.auth_token

  cluster_mode = var.cluster_mode == "enabled" ? [{
    num_node_groups         = var.number_of_node_groups
    replicas_per_node_group = var.replicas_per_node_group
  }] : null

  tags = var.tags
  log_delivery_configuration = var.log_delivery_configuration
}
