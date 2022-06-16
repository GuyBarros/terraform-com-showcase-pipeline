
# Vault config
resource "vault_jwt_auth_backend" "okta_oidc" {
  provider = vault.app
  description        = "Okta OIDC"
  path               = var.okta_mount_path
  type               = "oidc"
  oidc_discovery_url = okta_auth_server.vault.issuer
  bound_issuer       = okta_auth_server.vault.issuer
  oidc_client_id     = okta_app_oauth.vault.client_id
  oidc_client_secret = okta_app_oauth.vault.client_secret
  default_role        = "okta_admin"
  tune {
    listing_visibility = "unauth"
    default_lease_ttl  = var.okta_default_lease_ttl
    max_lease_ttl      = var.okta_max_lease_ttl
    token_type         = var.okta_token_type
  }
}

resource "vault_jwt_auth_backend_role" "okta_role" {
  provider = vault.app
  for_each       = var.roles
  backend        = vault_jwt_auth_backend.okta_oidc.path
  role_name      = each.key
  token_policies = each.value.token_policies

  allowed_redirect_uris = ["${var.vault_address}/ui/vault/auth/${var.okta_mount_path}/oidc/callback",
  # "${var.vault_address}/v1/auth/${var.okta_mount_path}/oidc/callback",
     # This is for logging in with the CLI if you want.
    "http://localhost:${var.cli_port}/oidc/callback",
  ]

  user_claim      = "email"
  #user_claim      = "sub"
  role_type       = "oidc"
  bound_audiences = [var.okta_auth_audience, okta_app_oauth.vault.client_id]
  # bound_audiences = [okta_auth_server.vault.audiences]
  oidc_scopes = [
    "openid",
    "profile",
    "email",
  ]
  bound_claims = {
    groups = join(",", each.value.bound_groups)
  }
  verbose_oidc_logging = true
}

# add KV for developers
resource "vault_mount" "developers" {
  provider = vault.app
  type = "kv"
  path = "developers"
}

