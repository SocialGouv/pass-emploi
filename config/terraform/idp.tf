resource "keycloak_oidc_identity_provider" "realm_identity_provider" {
  realm                         = keycloak_realm.pass-emploi.id
  alias                         = "similo-conseiller"
  display_name                  = "SIMILO - Conseillers"
  authorization_url             = "https://sso-dev.i-milo.fr/auth/realms/imilo-IC-0/protocol/openid-connect/auth"
  client_id                     = "sue-portail-conseiller"
  client_secret                 = "NO_SECRET"
  token_url                     = "https://sso-dev.i-milo.fr/auth/realms/imilo-IC-0/protocol/openid-connect/token"
  store_token                   = true
  add_read_token_role_on_create = true
  logout_url                    = "https://sso-dev.i-milo.fr/auth/realms/imilo-IC-0/protocol/openid-connect/logout"
  
  
  
  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}
