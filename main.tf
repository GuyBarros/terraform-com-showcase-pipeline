///////////////// Vault Namespace

provider "vault" {
  address = var.vault_address
  namespace = "admin"
}

provider "vault" {
  alias     = "app"
  address = var.vault_address
  namespace = trimsuffix(vault_namespace.app.id, "/")
}






