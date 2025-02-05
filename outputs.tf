output "primary_endpoint_address" {
  description = "Adresse de l'endpoint principal du cluster Redis."
  value       = module.elasticache.primary_endpoint_address
}

output "reader_endpoint_address" {
  description = "Adresse de l'endpoint lecteur du cluster Redis (si applicable)."
  value       = module.elasticache.reader_endpoint_address
}

output "configuration_endpoint_address" {
  description = "Adresse de l'endpoint de configuration du cluster Redis (si applicable)."
  value       = module.elasticache.configuration_endpoint_address
}

output "cluster_id" {
  description = "Identifiant du cluster ElastiCache."
  value       = module.elasticache.cluster_id
}

output "engine_version_actual" {
  description = "Version réelle du moteur Redis utilisée par le cluster."
  value       = module.elasticache.engine_version_actual
}
