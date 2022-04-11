resource "keycloak_openid_client" "keycloak_openid_client_api" {
  realm_id      = keycloak_realm.pass-emploi.id
  client_id     = "pass-emploi-api"
  client_secret = var.api_client_secret

  name = "Pass Emploi API"

  access_type = "CONFIDENTIAL"
  service_accounts_enabled = true
}


