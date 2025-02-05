variable "cluster_id" {
  description = "Identifiant unique pour le cluster ElastiCache."
  type        = string
}

variable "engine_version" {
  description = "Version du moteur Redis à utiliser."
  type        = string
  default     = "7.0"
  validation {
    condition     = can(regex("^6\\.x|7\\.x$", var.engine_version))
    error_message = "La version du moteur doit être 6.x ou 7.x."
  }
}

variable "node_type" {
  description = "Type d'instance pour les nœuds du cluster."
  type        = string
  default     = "cache.t3.micro"
}

variable "num_cache_nodes" {
  description = "Nombre de nœuds dans le cluster."
  type        = number
  default     = 1
  validation {
    condition     = var.num_cache_nodes > 0
    error_message = "Le nombre de nœuds doit être supérieur à 0."
  }
}

variable "subnet_ids" {
  description = "Liste des IDs des sous-réseaux pour le cluster."
  type        = list(string)
}

variable "vpc_id" {
  description = "ID du VPC où le cluster sera déployé."
  type        = string
}

variable "security_group_ids" {
  description = "Liste des IDs des groupes de sécurité à associer au cluster."
  type        = list(string)
  default     = []
}

variable "snapshot_retention_limit" {
  description = "Nombre de jours pendant lesquels ElastiCache conserve les snapshots automatiques avant de les supprimer. Mettre à 0 pour désactiver les snapshots."
  type        = number
  default     = 7
}

variable "snapshot_window" {
  description = "Fenêtre horaire quotidienne (au format hh24:mi-hh24:mi) pendant laquelle les snapshots automatiques sont créés."
  type        = string
  default     = "05:00-06:00"
}

variable "parameter_group_name" {
  description = "Nom du groupe de paramètres à associer au cluster."
  type        = string
  default     = "default.redis7.x"
}

variable "at_rest_encryption_enabled" {
  description = "Indique si le chiffrement des données au repos est activé."
  type        = bool
  default     = true
}

variable "transit_encryption_enabled" {
  description = "Indique si le chiffrement des données en transit est activé."
  type        = bool
  default     = true
}

variable "auth_token" {
  description = "Jeton d'authentification Redis AUTH pour sécuriser l'accès au cluster."
  type        = string
  default     = null
}

variable "cluster_mode" {
  description = "Configuration du mode cluster pour le sharding. Définir 'enabled' pour activer le sharding, sinon 'disabled'."
  type        = string
  default     = "disabled"
  validation {
    condition     = var.cluster_mode == "enabled" || var.cluster_mode == "disabled"
    error_message = "Le mode cluster doit être 'enabled' ou 'disabled'."
  }
}

variable "number_of_node_groups" {
  description = "Nombre de groupes de nœuds (shards) pour le cluster en mode cluster. Applicable uniquement si cluster_mode est 'enabled'."
  type        = number
  default     = 1
}

variable "replicas_per_node_group" {
  description = "Nombre de nœuds réplicas par groupe de nœuds. Applicable uniquement si cluster_mode est 'enabled'."
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags à appliquer aux ressources."
  type        = map(string)
  default     = {}
}


variable "log_delivery_configuration" {
  description = "Configuration de la livraison des journaux pour le cluster Redis."
  type = list(object({
    log_type         = string
    destination_type = string
    log_format       = string
    destination_details = object({
      cloudwatch_logs_details = object({
        log_group = string
      })
    })
  }))
  default = []
}
