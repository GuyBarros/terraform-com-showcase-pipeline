provider "consul" {
  address    = var.consul_address
}

resource "consul_namespace" "production" {
  name        = var.application_name
  description = "My awesome consul namespace"
}

resource "consul_acl_policy" "app" {
  name        = "${var.application_name}_policy"
  rules       = <<-RULE
    node_prefix "" {
      policy = "read"
    }
    RULE
}