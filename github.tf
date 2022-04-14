resource "github_repository" "app" {
  name        = var.application_name
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true
  gitignore_template = "Node"
  license_template = "apache-2.0"


}


resource "github_repository" "app-dev-enviroment" {
  name        = "${var.application_name}-dev-enviroment"
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true
  gitignore_template = "Terraform"
  license_template = "apache-2.0"


}

resource "github_repository" "app-qa-enviroment" {
  name        = "${var.application_name}-qa-enviroment"
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true
  gitignore_template = "Terraform"
  license_template = "apache-2.0"


}

resource "github_repository" "app-preprod-enviroment" {
  name        = "${var.application_name}-preprod-enviroment"
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true
  gitignore_template = "Terraform"
  license_template = "apache-2.0"


}

resource "github_repository" "app-prod-enviroment" {
  name        = "${var.application_name}-prod-enviroment"
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true
  gitignore_template = "Terraform"
  license_template = "apache-2.0"


}


/*
resource "github_repository_file" "example" {
  repository          = github_repository.app.name
  branch              = "main"
  file                = "${var.application_name}.example.txt"
  content             = <<EOT
 example text to show I can put anything in here
  EOT
  overwrite_on_create = true
}
*/


resource "github_repository_file" "app-github-action" {
  repository          = github_repository.app.name
  branch              = "main"
  file                = ".github/workflows/packer-builder.yml"
  content             = <<EOT
 name: ImageBuilder
# Run this workflow every time a new commit pushed to your repository
on: push
jobs:
  build:
    runs-on: self-hosted
    if: "! contains(github.event.head_commit.message, 'build')"
    steps:
      - name: Get AppRole RoleID
        id: get_aprole_role_id
        run: echo "::set-output name=roleId::$(vault read -field=role_id auth/approle/role/github/role-id)"
      - name: Get AppRole SecretID
        id: get_aprole_secret_id
        run: echo "::set-output name=secretId::$(vault write -f -field=secret_id auth/approle/role/github/secret-id)"
      - name: Test AppRole RoleID
        id: test_aprole_roleid
        run: echo $${{ steps.get_aprole_role_id.outputs.roleId }}
      - name: Test AppRole Secret ID
        id: test_aprole_secretID
        run: echo $${{ steps.get_aprole_secret_id.outputs.secretId }}
      - name: Import Secrets
        id: secrets
        uses: hashicorp/vault-action@v2.3.1
        with:
          url: ${var.vault_address}
          tlsSkipVerify: true
          namespace: admin
          method: approle
          roleId: $${{ steps.get_aprole_role_id.outputs.roleId }}
          secretId: $${{ steps.get_aprole_secret_id.outputs.secretId }}
          secrets: |
            kv/data/ci_app_secret app_secret | APP_SECRET
      - name: Build Artifact
          uses: hashicorp/packer-github-actions@master
          with:
            command: build
            arguments: "-color=false -on-error=abort"
            target: ${var.application_name}.pkr.hcl
          env:
            PACKER_LOG: 1
EOT
  overwrite_on_create = true
}

resource "github_repository_file" "example2" {
  repository          = github_repository.app.name
  branch              = "main"
  file                = ".${var.application_name}/${var.application_name}.example.txt"
  content             = <<EOT
 example text to show I can put anything in here
  EOT
  overwrite_on_create = true
}

resource "github_repository_file" "packer" {
  repository          = github_repository.app.name
  branch              = "main"
  file                = "${var.application_name}.pkr.hcl"
  content             = <<EOT
    variable "release_version" {
  type    = string
  default = "0.0.1"
}

packer {
  required_plugins {
    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">= 1.0.1"
    }

  }
}

/// Docker //////
source "docker" "node-alpine" {
  image  = "node:17-alpine"
  commit = true
   changes = [
     "ENTRYPOINT node dist/main",
   ]
}

build {
  name = "${var.application_name}"
  sources = [
    "source.docker.node-alpine"
  ]
  provisioner "file" {
  source = "."
  destination = "."
}
  provisioner "shell" {
  environment_vars = [
    "FOO=hello world",
  ]
  inline = [
    "echo Starting to build the NodeJS Application",
    "rm  ${var.application_name}.pkr.hcl ${var.application_name}.nomad",
    "npm run build",
  ]
}

post-processors {
post-processor "docker-tag" {
    repository = "${var.docker_hub_namespace}/${var.application_name}"
    tags       = ["latest", var.release_version]
  }

 post-processor "docker-push" { }
}
}

  EOT
  overwrite_on_create = true
}

resource "github_repository_file" "nomad" {
  repository          = github_repository.app.name
  branch              = "main"
  file                = "${var.application_name}.nomad"
  content             = <<EOT
 job "${var.application_name}" {
  datacenters = ["eu-west-2a","eu-west-2b","eu-west-2c"]
  type = "service"
  group "${var.application_name}" {
    count = 1

    update {
      max_parallel = 1
      health_check = "checks"
      min_healthy_time = "15s"
      healthy_deadline = "2m"
      # canary = 3
    }
    network {
      mode = "bridge"
      port "http" {
        to = 8000
      }
    }
    task "${var.application_name}" {
      driver = "docker"
      config {
        image = "${var.docker_hub_namespace}/${var.application_name}:latest"
      }
      env {
        MONGODB_SERVER = "127.0.0.1"
        MONGODB_PORT = "27017"
        MONGODB_COL = "todoapp"
      }
    } # end ${var.application_name} task
    service {
      name = "${var.application_name}"
      tags = [
        "global",
        "urlprefix-/todos",
        "traefik.enable=true",
        "traefik.http.routers.chat.rule=PathPrefix(`/todos`)",
      ]
      port = "http"
        check {
        name     = "${var.application_name} alive"
        type     = "http"
        path     = "/todos"
        interval = "10s"
        timeout  = "2s"
      }
      connect {
        sidecar_service {
          tags = ["${var.application_name}-proxy"]
          proxy {
            upstreams {
              destination_name = "mongodb"
              local_bind_port = 27017
            }
          }
        }
      } # end connnect
    } # end service
  } # end chat-app group
}
  EOT
  overwrite_on_create = true
}


resource "github_repository_file" "tf-dev" {
  repository          = github_repository.app-dev-enviroment.name
  branch              = "main"
  file                = "${var.application_name}-dev-example.tf"
  content             = <<EOT
 resource "null_resource" "example" {

  }

  EOT
  overwrite_on_create = true
}

resource "github_repository_file" "tf-qa" {
  repository          = github_repository.app-qa-enviroment.name
  branch              = "main"
  file                = "${var.application_name}-qa-example.tf"
  content             = <<EOT
 resource "null_resource" "example" {

  }

  EOT
  overwrite_on_create = true
}

resource "github_repository_file" "tf-preprod" {
  repository          = github_repository.app-preprod-enviroment.name
  branch              = "main"
  file                = "${var.application_name}-preprod-example.tf"
  content             = <<EOT
 resource "null_resource" "example" {

  }

  EOT
  overwrite_on_create = true
}

resource "github_repository_file" "tf-prod" {
  repository          = github_repository.app-prod-enviroment.name
  branch              = "main"
  file                = "${var.application_name}-prod-example.tf"
  content             = <<EOT
 resource "null_resource" "example" {

  }

  EOT
  overwrite_on_create = true
}
