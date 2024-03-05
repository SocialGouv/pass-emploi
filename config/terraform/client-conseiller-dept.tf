resource "keycloak_openid_client" "keycloak_openid_client_conseiller_dept" {
  realm_id      = keycloak_realm.pass-emploi.id
  client_id     = "pass-emploi-conseiller-dept"
  client_secret = var.conseiller_dept_client_secret

  name        = "Pass Emploi - Conseiller Départemental"
  login_theme = "keycloak"

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = var.conseiller_dept_valid_redirect_uris

  standard_flow_enabled = true
}

resource "keycloak_openid_client_default_scopes" "pass-emploi-conseiller-dept-default-scopes" {
  realm_id  = keycloak_realm.pass-emploi.id
  client_id = keycloak_openid_client.keycloak_openid_client_conseiller_dept.id

  default_scopes = [
    keycloak_openid_client_scope.pass_emploi_user_scope.name,
    "roles",
    "profile",
    "email",
    "openid"
  ]
}

