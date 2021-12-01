resource "keycloak_openid_client" "app" {
  realm_id = keycloak_realm.pass-emploi.id
  client_id = "pass-emploi-app"
  client_secret = var.app_client_secret

  name = "Pass Emploi APP"

  access_type = "CONFIDENTIAL"
  valid_redirect_uris = var.app_valid_redirect_uris

  standard_flow_enabled = true
  authentication_flow_binding_overrides {
    browser_id = keycloak_authentication_flow.pass-emploi-browser.id
  }
}
