resource "gitlab_project" "app" {
  name        = var.application_name
  description = "My awesome codebase"
  visibility_level = "public"
}



resource "gitlab_repository_file" "app" {
  project   = gitlab_project.app.id
  file_path = ".gitlab-ci.yml"
  branch    = "main"
  // content will be auto base64 encoded
  content        = <<EOT
 image:
    name: vault:1.9.0

stages:
  - checkvars
  - readsecret

before_script:
  - export VAULT_ADDR=https://do-not-delete-ever.vault.92607e45-319d-44bd-9879-284b72f492b8.aws.hashicorp.cloud:8200
  - export VAULT_NAMESPACE=${var.application_name}
  - export VAULT_TOKEN="$(vault write -field=token auth/gitlab_jwt/login role=app-pipeline jwt=$CI_JOB_JWT)"
  - export VAULT_SECRET="$(vault kv get -field=foo kv/test)"

print variables:
  stage: checkvars
  script:
    - echo $VAULT_ADDR
    - echo $VAULT_NAMESPACE

read secret:
  stage: readsecret
  environment:
    name: DEMOSTACK
  secrets:
    DATABASE_PASSWORD:
        vault: kv/test/foo
  script:
    - echo $VAULT_SECRET
    - echo $DATABASE_PASSWORD
    - cat $DATABASE_PASSWORD

  EOT
  commit_message = "initial CI/CD commit"
}

