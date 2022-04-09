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

 variable "vault_token" {
  description = "the Vault Address"
  sensitive = true
}

 variable "consul_address" {
  description = "the Consul Address"
}

 variable "consul_token" {
  description = "the Consul Token to set up the Vault backend"
  sensitive = true
}

 variable "nomad_address" {
  description = "the Nomad Address"
}


 variable "tfe_username" {
  description = ""
}

 variable "tfe_organization" {
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

variable "github_provider_token" {
  type        = string
  description = "Token for Github provider"
  sensitive = true
}

variable "docker_hub_namespace" {
  type        = string
  description = "Docker Hub namespace where repo will be created"
  sensitive = false
}

variable "docker_hub_username" {
  type        = string
  description = "Docker Hub username"
  sensitive = false
}


variable "docker_hub_password" {
  type        = string
  description = "Docker Hub password"
  sensitive = true
}
