

resource "consul_namespace" "dev" {
  name        = var.application_name
  description = "Shared development environment."
}

resource "consul_intention" "deny" {
  source_name      = "*"
  destination_name = "*"
  action           = "deny"
}

resource "consul_intention" "app" {
  source_name      = var.application_name
  destination_name = "mongodb"
  action           = "allow"
}

resource "consul_intention" "fabio" {
  source_name      = "fabio"
  destination_name = "*"
  action           = "allow"
}

/*
resource "consul_acl_policy" "app" {
  name        = "${var.application_name}_policy"
  rules       = <<-RULE
    node_prefix "" {
      policy = "read"
    }
    RULE
}
*/

/*
resource "consul_config_entry" "service_intentions" {
  name = "api-service"
  kind = "service-intentions"

  config_json = jsonencode({
    Sources = [
      {
        Action     = "allow"
        Name       = "frontend-webapp"
        Precedence = 9
        Type       = "consul"
      },
      {
        Action     = "allow"
        Name       = "nightly-cronjob"
        Precedence = 9
        Type       = "consul"
      }
    ]
  })
}
*/