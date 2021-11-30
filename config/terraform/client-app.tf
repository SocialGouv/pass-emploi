resource "keycloak_openid_client" "app" {
  realm_id = keycloak_realm.pass-emploi.id
  client_id = "pass-emploi-app"
  client_secret = "ad7bc35e-8b11-4dff-8a6c-341158371b4e"

  name = "Pass Emploi APP"

  access_type = "CONFIDENTIAL"
  valid_redirect_uris = [
    "une_uri_qui_va_bien"
  ]

  standard_flow_enabled = true
  authentication_flow_binding_overrides {
    browser_id = keycloak_authentication_flow.pass-emploi-browser.id
  }
}
