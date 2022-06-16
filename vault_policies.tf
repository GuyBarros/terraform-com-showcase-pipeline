# policies.tf

# Create the data for the policies
data "vault_policy_document" "admin_policy_content" {
  rule {
    path         = "*"
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
    description  = "Policy that allows everything. When given to a token in a namespace, will be like a namespace-root token"
  }
}

data "vault_policy_document" "devs_policy_content" {
  rule {
    path         = "developers/*"
    capabilities = ["create", "read", "update", "delete", "list"]
    description  = ""
  }
}

# add the policies
resource "vault_policy" "admin" {
  provider = vault.app
  name   = "admin-policy"
  policy = data.vault_policy_document.admin_policy_content.hcl
}

resource "vault_policy" "devs" {
  provider = vault.app
  name   = "devs-policy"
  policy = data.vault_policy_document.devs_policy_content.hcl
}