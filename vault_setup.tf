resource "vault_namespace" "app" {
  path = var.application_name
}

resource "vault_auth_backend" "app" {
  provider = vault.app
  type     = "approle"
  tune {
    max_lease_ttl     = "8760h"
    default_lease_ttl = "8760h"
  }
}

module "vault_approle" {
     providers = {
    vault = vault.app
  }
  source            = "git::https://github.com/devops-adeel/terraform-vault-approle.git?ref=v0.7.0"
  application_name  = var.application_name
  env               = "dev"
  service           = "web"
  identity_group_id = module.vault_static_secrets.identity_group_id
  mount_accessor    = vault_auth_backend.app.accessor
}

module "vault_static_secrets" {
    providers = {
    vault = vault.app
  }
  source      = "git::https://github.com/devops-adeel/terraform-vault-secrets-kv.git?ref=v0.3.0"
}

module "vault_tfc_secrets" {
    providers = {
    vault = vault.app
  }
  source      = "git::https://github.com/devops-adeel/terraform-vault-secrets-tfc.git?ref=v0.4.0"
   token = var.tfe_token
  # token = tfe_team_token.app-team-token.token
}
