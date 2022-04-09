# terraform-com-showcase-pipeline
a demo enviroment that creates a githup repo, a TF Workspace and a Vault namespace all integrated.

ENV Variables
```bash
export VAULT_ADDR=
export VAULT_TOKEN=
export GITHUB_TOKEN=
export CONSUL_ADDR=
export CONSUL_TOKEN=

```


terraform.tfvars
```ruby
application_name = ""
vault_namespace = ""
vault_address = ""
consul_address = ""
consul_token = ""
tfe_username = ""
tfe_organization = ""
tfe_token = ""
tfe_oauth_token_id= "" # for the CVS set up in TFC, you can get it from the settings page under VCS providers
```