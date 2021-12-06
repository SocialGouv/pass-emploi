resource "keycloak_oidc_identity_provider" "idp_similo_conseiller" {
  realm                         = keycloak_realm.pass-emploi.id
  alias                         = "similo-conseiller"
  display_name                  = "SIMILO - Conseillers"
  authorization_url             = var.idp_similo_conseiller_authorization_url
  client_id                     = "sue-portail-conseiller"
  client_secret                 = var.idp_similo_conseiller_client_secret
  token_url                     = var.idp_similo_conseiller_token_url
  store_token                   = true
  add_read_token_role_on_create = true
  logout_url                    = var.idp_similo_conseiller_logout_url
  post_broker_login_flow_alias  = keycloak_authentication_flow.pass-emploi-idp.alias
  sync_mode                     = "FORCE"
  
  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_custom_identity_provider_mapper" "id_milo" {
  realm                    = keycloak_realm.pass-emploi.id
  name                     = "id-milo-attribute-importer"
  identity_provider_alias  = keycloak_oidc_identity_provider.idp_similo_conseiller.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    claim = "sub"
    syncMode = "IMPORT"
   "user.attribute" = "idMilo"
  }
}