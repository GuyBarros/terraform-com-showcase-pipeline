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


variable "gitlab_default_lease_ttl" {
  type        = string
  description = "Default lease TTL for Vault tokens"
  default     = "12h"
}

variable "gitlab_max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for Vault tokens"
  default     = "768h"
}

variable "gitlab_token_type" {
  type        = string
  description = "Token type for Vault tokens"
  default     = "default-service"
}

variable "gitlab_token" {
  type        = string
  description = "Gitlab provider token"
  sensitive = true
}

///////////////////////////////////OKTA/////////////////////////////////////

variable "okta_org_name" {
  type        = string
  description = "The org name, ie for dev environments `dev-123456`"
}

variable "okta_base_url" {
  type        = string
  description = "The Okta SaaS endpoint, usually okta.com or oktapreview.com"
}

variable "okta_base_url_full" {
  type        = string
  description = "Full URL of Okta login, usually instanceID.okta.com, ie https://dev-208447.okta.com"
}

variable "okta_issue_mode" {
  type        = string
  description = "Indicates whether the Okta Authorization Server uses the original Okta org domain URL or a custom domain URL as the issuer of ID token for this client. ORG_URL = foo.okta.com, CUSTOM_URL = custom domain"
  default     = "ORG_URL"
}

variable "okta_api_token" {
  type        = string
  description = "Okta API key"
}

variable "okta_allowed_groups" {
  type        = list(any)
  description = "Okta group for Vault admins"
  default     = ["vault_admins"]
}

variable "okta_mount_path" {
  type        = string
  description = "Mount path for Okta auth"
  default     = "okta_oidc"
}

variable "okta_user_email" {
  type        = string
  description = "e-mail of a user to dynamically add to the groups created by this config"
}

# variable "okta_tile_app_label" {
#   type        = string
#   description = "HCP Vault"
# }

# variable "okta_client_id" {
#   type        = string
#   description = "Okta Vault app client ID"
# }

# variable "okta_client_secret" {
#   type        = string
#   description = "Okta Vault app client secret"
# }

# variable "okta_bound_audiences" {
#   type        = list(any)
#   description = "A list of allowed token audiences"
# }

variable "okta_auth_audience" {
  type        = string
  description = ""
  default     = "api://vault"
}

variable "cli_port" {
  type        = number
  description = "Port to open locally to login with the CLI"
  default     = 8250
}

variable "okta_default_lease_ttl" {
  type        = string
  description = "Default lease TTL for Vault tokens"
  default     = "12h"
}

variable "okta_max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for Vault tokens"
  default     = "768h"
}

variable "okta_token_type" {
  type        = string
  description = "Token type for Vault tokens"
  default     = "default-service"
}

variable "roles" {
  type    = map(any)
  default = {}

  description = <<EOF
Map of Vault role names to their bound groups and token policies. Structure looks like this:
```
roles = {
  okta_admin = {
    token_policies = ["admin-policy","superadmin"]
    bound_groups = ["vault-admins-test1"]
  },
  okta_devs  = {
    token_policies = ["devs-policy","superadmin"]
    bound_groups = ["vault-devs-test1"]
  }
}
```
EOF
}

######################################### Boundary #################################################
variable "boundary_address" {
  description = "Boundary Host"
  default     = ""
}

variable "auth_method_id" {
  description = "Boundary Auth Method"
  default     = ""
}

variable "username" {
  description = "Boundary Username"
  default     = "admin"
}

variable "password" {
  description = "Boundary Password"
  default     = ""
}


variable "backend_server_ips" {
  type = set(string)
  default = [
    "server-0.eu-guystack.original.aws.hashidemos.io",
    "server-1.eu-guystack.original.aws.hashidemos.io",
    "server-2.eu-guystack.original.aws.hashidemos.io",
  ]
}

# Vault Dynamic DB Cred

//PostgresSQL
variable "postgres_hostname" {
  description = "the hostname of the MySQL Database we will configure in Vault"
}
variable "postgres_port" {
  description = "the port of the MySQL Database we will configure in Vault"
}
variable "postgres_name" {
  description = "the Name of the MySQL Database we will configure in Vault"
}
variable "postgres_username" {
  description = "the admin username of the MySQL Database we will configure in Vault"
}
variable "postgres_password" {
  description = "the password for admin username of the MySQL Database we will configure in Vault(this will be rotated after config)"
}
variable "sshca_public_key"{
 description = "the public key that will be signed by the SSH CA Secret Engine"
}

variable "sshca_hostname"{
  description = "the FQDN for the SSH CA target"
}

