// l'utilisation de depends_on permet d'assurer les priorités du flow car l'API de keycloak ne le permet pas
// la priorité est assurée par l'ordre de création
// source --> https://github.com/mrparkers/terraform-provider-keycloak/issues/296

########### BROWSER ###########
resource "keycloak_authentication_flow" "pass-emploi-browser" {
  realm_id    = keycloak_realm.pass-emploi.id
  alias       = "pass-emploi-browser"
  provider_id = "basic-flow"
}

resource "keycloak_authentication_subflow" "pass-emploi-browser-authentication" {
  depends_on        = [keycloak_authentication_flow.pass-emploi-browser]
  realm_id          = keycloak_realm.pass-emploi.id
  parent_flow_alias = keycloak_authentication_flow.pass-emploi-browser.alias
  alias             = "pass-emploi-browser-authentication"
  provider_id       = "basic-flow"
  requirement       = "REQUIRED"
}

resource "keycloak_authentication_execution" "pass-emploi-browser-cookie-execution" {
  depends_on        = [keycloak_authentication_subflow.pass-emploi-browser-authentication]
  realm_id          = keycloak_realm.pass-emploi.id
  parent_flow_alias = keycloak_authentication_subflow.pass-emploi-browser-authentication.alias
  requirement       = "ALTERNATIVE"
  authenticator     = "auth-cookie"
}

resource "keycloak_authentication_subflow" "pass-emploi-browser-authentication-form" {
  depends_on        = [keycloak_authentication_execution.pass-emploi-browser-cookie-execution]
  realm_id          = keycloak_realm.pass-emploi.id
  parent_flow_alias = keycloak_authentication_subflow.pass-emploi-browser-authentication.alias
  alias             = "pass-emploi-browser-authentication-form"
  provider_id       = "basic-flow"
  requirement       = "ALTERNATIVE"
}

resource "keycloak_authentication_execution" "pass-emploi-browser-username-password-execution" {
  depends_on        = [keycloak_authentication_subflow.pass-emploi-browser-authentication-form]
  realm_id          = keycloak_realm.pass-emploi.id
  parent_flow_alias = keycloak_authentication_subflow.pass-emploi-browser-authentication-form.alias
  requirement       = "REQUIRED"
  authenticator     = "auth-username-password-form"
}

resource "keycloak_authentication_execution" "pass-emploi-custom-execution" {
  depends_on        = [keycloak_authentication_subflow.pass-emploi-browser-authentication-form]
  realm_id          = keycloak_realm.pass-emploi.id
  parent_flow_alias = keycloak_authentication_subflow.pass-emploi-browser-authentication-form.alias
  requirement       = "REQUIRED"
  authenticator     = "user-authenticator-pass-emploi"
}


########### IDP ###########
resource "keycloak_authentication_flow" "pass-emploi-idp" {
  realm_id    = keycloak_realm.pass-emploi.id
  alias       = "pass-emploi-idp"
  provider_id = "basic-flow"
}

resource "keycloak_authentication_execution" "pass-emploi-idp-execution" {
  depends_on        = [keycloak_authentication_flow.pass-emploi-idp]
  realm_id          = keycloak_realm.pass-emploi.id
  parent_flow_alias = keycloak_authentication_flow.pass-emploi-idp.alias
  requirement       = "REQUIRED"
  authenticator     = "user-authenticator-conseiller-milo"
}
