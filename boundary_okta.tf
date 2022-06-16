
resource "boundary_auth_method_oidc" "okta_oidc" {
  name                 = "Okta ${var.application_name}"
  description          = "OIDC auth method for Okta"
  scope_id             = boundary_scope.app.id
  issuer             = okta_auth_server.vault.issuer
  client_id          = okta_app_oauth.vault.client_id
  client_secret      = okta_app_oauth.vault.client_secret
  signing_algorithms = ["RS256"]
  api_url_prefix     = var.boundary_address
}

resource "boundary_account_oidc" "oidc_user" {
  name           = "OIDC_USER"
  description    = "OIDC account for user1"
  auth_method_id = boundary_auth_method_oidc.okta_oidc.id
  issuer  = okta_auth_server.vault.issuer
  subject = data.okta_user.vault.id
}

