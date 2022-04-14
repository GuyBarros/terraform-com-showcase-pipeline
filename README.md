# terraform-com-showcase-pipeline
a demo enviroment that creates a githup repo, a TF Workspace and a Vault namespace all integrated.

the main variable this code needs is *application_name*, with the tfvars bellow, application_name will be a variable passed in at runtime.




terraform.tfvars
```ruby

vault_namespace = ""
vault_token = ""
vault_address = ""
consul_address = ""
consul_token = ""
nomad_address = ""
tfe_username = ""
tfe_organization = ""
tfe_token = ""
tfe_oauth_token_id= "" # for the CVS set up in TFC, you can get it from the settings page under VCS providers
github_provider_token=""
docker_hub_namespace=""
docker_hub_username=""
docker_hub_password=""
gitlab_token=""

```