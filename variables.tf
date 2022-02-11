variable "application_name" {
     type        = string
     description = "the application identifier which will create github repo, terraform workspace, vault namespace"
}

 variable "vault_namespace" {
  description = "the HCP Vault namespace we will use for mounting the database secret engine"
  default = "admin"
}

 variable "vault_address" {
  description = "the Vault Address"
}

 variable "consul_address" {
  description = "the Consul Address"
}

 variable "consul_token" {
  description = "the Consul Token to set up the Vault backend"
  sensitive = true
}

 variable "username" {
  description = ""
}

 variable "organization" {
  description = ""
}

 variable "tfe_token" {
  description = ""
  sensitive = true
}

 variable "tfe_oauth_token_id" {
  description = ""
  sensitive = true
}

variable "github_default_lease_ttl" {
  type        = string
  description = "Default lease TTL for Vault tokens"
  default     = "12h"
}

variable "github_max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for Vault tokens"
  default     = "768h"
}

variable "github_token_type" {
  type        = string
  description = "Token type for Vault tokens"
  default     = "default-service"
}
