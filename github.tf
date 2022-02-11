resource "github_repository" "app" {
  name        = var.application_name
  description = "My awesome codebase"

  visibility = "public"
  auto_init = true
  gitignore_template = "Terraform"
  license_template = "apache-2.0"


}



