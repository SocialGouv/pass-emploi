########### CONSEILLER MILO ###########
resource "keycloak_oidc_identity_provider" "idp_milo_conseiller" {
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
  post_broker_login_flow_alias  = keycloak_authentication_flow.pass-emploi-idp-conseiller-milo.alias
  sync_mode                     = "FORCE"
  hide_on_login_page            = true
  enabled                       = var.idp_similo_conseiller_enabled

  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_custom_identity_provider_mapper" "id_milo_conseiller" {
  realm                    = keycloak_realm.pass-emploi.id
  name                     = "id-milo-attribute-importer"
  identity_provider_alias  = keycloak_oidc_identity_provider.idp_milo_conseiller.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    claim = "sub"
    syncMode = "IMPORT"
   "user.attribute" = "idMilo"
  }
}

########### JEUNE MILO ###########
resource "keycloak_oidc_identity_provider" "idp_milo_jeune" {
  realm                         = keycloak_realm.pass-emploi.id
  alias                         = "similo-jeune"
  display_name                  = "SIMILO - Jeunes"
  authorization_url             = var.idp_similo_jeune_authorization_url
  client_id                     = "sue-portail-jeunes"
  client_secret                 = var.idp_similo_jeune_client_secret
  token_url                     = var.idp_similo_jeune_token_url
  store_token                   = true
  add_read_token_role_on_create = true
  logout_url                    = var.idp_similo_jeune_logout_url
  post_broker_login_flow_alias  = keycloak_authentication_flow.pass-emploi-idp-jeune-milo.alias
  sync_mode                     = "FORCE"
  hide_on_login_page            = true
  enabled                       = var.idp_similo_jeune_enabled

  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_custom_identity_provider_mapper" "id_milo_jeune" {
  realm                    = keycloak_realm.pass-emploi.id
  name                     = "id-milo-jeune-attribute-importer"
  identity_provider_alias  = keycloak_oidc_identity_provider.idp_milo_jeune.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    claim = "sub"
    syncMode = "IMPORT"
    "user.attribute" = "idMilo"
  }
}

########### CONSEILLER PE ###########
resource "keycloak_oidc_identity_provider" "idp_pe_conseiller" {
  realm                         = keycloak_realm.pass-emploi.id
  alias                         = "pe-conseiller"
  display_name                  = "PE - Conseillers"
  authorization_url             = var.idp_pe_conseiller_authorization_url
  client_id                     = var.idp_pe_conseiller_client_id
  client_secret                 = var.idp_pe_conseiller_client_secret
  token_url                     = var.idp_pe_conseiller_token_url
  store_token                   = true
  add_read_token_role_on_create = true
  logout_url                    = var.idp_pe_conseiller_logout_url
  post_broker_login_flow_alias  = keycloak_authentication_flow.pass-emploi-idp-conseiller-pe.alias
  sync_mode                     = "FORCE"
  default_scopes                = "openid application_AGT_AAA-TEST-APPLI email profile"
  hide_on_login_page            = true
  enabled                       = var.idp_pe_conseiller_enabled

  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}
