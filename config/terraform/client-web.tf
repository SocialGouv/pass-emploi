resource "keycloak_openid_client" "web" {
  realm_id = keycloak_realm.pass-emploi.id
  client_id = "pass-emploi-web"
  client_secret = var.web_client_secret

  name = "Pass Emploi WEB"

  access_type = "CONFIDENTIAL"
  valid_redirect_uris = var.web_valid_redirect_uris

  standard_flow_enabled = true
  authentication_flow_binding_overrides {
    browser_id = keycloak_authentication_flow.pass-emploi-browser.id
  }
}
