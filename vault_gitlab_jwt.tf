resource "vault_jwt_auth_backend" "gitlab" {
    provider = vault.app
description = "JWT auth backend for Gitlab-CI pipeline"
path = "gitlab_jwt"
jwks_url = "https://gitlab.com/-/jwks"
bound_issuer = "gitlab.com"
default_role = "generic"
tune {
    listing_visibility = "unauth"
    default_lease_ttl  = var.gitlab_default_lease_ttl
    max_lease_ttl      = var.gitlab_max_lease_ttl
    token_type         = var.gitlab_token_type
  }
}

resource "vault_jwt_auth_backend_role" "pipeline"{
    provider = vault.app
    backend = vault_jwt_auth_backend.gitlab.path
    role_type = "jwt"

    role_name = "app-pipeline"
    token_policies = ["default", "hcp-root"]

    bound_claims = {
        project_id = gitlab_project.app.id
        ref        = "main"
        ref_type   = "branch"
    }

    user_claim = "environment"

    claim_mappings = {
        "project_id" = "project_id"
        "namespace_id" = "namespace_id"
        "namespace_path" = "namespace_path"
        "project_id" = "project_id"
        "project_path" = "project_path"
        "user_id" = "user_id"
        "user_login" = "user_login"
        "user_email" = "user_email"
        "pipeline_id" = "pipeline_id"
        "pipeline_source" = "pipeline_source"
        "job_id" = "job_id"
        "ref" = "ref"
        "ref_type" = "ref_type"
        "ref_protected" = "ref_protected"
        "environment" = "environment"
        "environment_protected" = "environment_protected"
    }
}
