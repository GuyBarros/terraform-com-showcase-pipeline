resource "tfe_workspace" "app_ws" {
  depends_on = [github_repository.app]
  name         = var.application_name
  organization = var.organization
  tag_names    = ["${var.application_name}", "COM", "showcase"]

  vcs_repo{
    identifier = github_repository.app.full_name
    oauth_token_id = var.tfe_oauth_token_id
  }

}

resource "tfe_team" "app_team" {
  name         = "${var.application_name}-team"
  organization = var.organization
}

resource "tfe_team_token" "app_team_token" {
  team_id = tfe_team.app_team.id
}


resource "tfe_team_access" "app_ws_team_access" {
  access       = "read"
  team_id      = tfe_team.app_team.id
  workspace_id = tfe_workspace.app_ws.id
}

resource "tfe_team_member" "app_team_member" {
  team_id  = tfe_team.app_team.id
  username = var.username
}
