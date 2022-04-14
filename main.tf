///////////////// Vault Namespace

provider "vault" {
  address = var.vault_address
 # namespace = var.vault_namespace
  token   = var.vault_token
}

provider "vault" {
  alias     = "app"
  address = var.vault_address
  namespace = trimsuffix(vault_namespace.app.id, "/")
  token   = var.vault_token
}

provider "tfe" {
  alias     = "app"
  token    = var.tfe_token
}

provider "github" {
  token = var.github_provider_token
}

provider "nomad" {
  address = var.consul_address
}

provider "consul" {
  address    = var.consul_address
  #token      = var.consul_token
}

provider "dockerhub" {
  username = var.docker_hub_username
  password = var.docker_hub_password
}

# Configure the GitLab Provider
provider "gitlab" {
  token = var.gitlab_token
}
