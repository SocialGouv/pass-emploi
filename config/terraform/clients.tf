resource "keycloak_openid_client" "web" {
  realm_id            = keycloak_realm.pass-emploi.id
  client_id           = "pass-emploi-web"
  client_secret       = "b208225f-addd-4600-8ae5-de6e19234551"

  name                = "Pass Emploi WEB"

  access_type         = "CONFIDENTIAL"
  valid_redirect_uris = [
    "http://localhost:3000/api/auth/callback/keycloak"
  ]

  standard_flow_enabled = true
  
}
