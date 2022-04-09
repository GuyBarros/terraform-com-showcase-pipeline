
resource "dockerhub_repository" "app" {
  name             = var.application_name
  namespace        = var.docker_hub_namespace
  description      = "automated Docker repository for App ${var.application_name}"
  full_description = <<EOF

  ${var.application_name} Registry

EOF
}