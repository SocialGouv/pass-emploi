variable "ssl_required" {
  type = string
  default = "all"
  description = "Enabled SSL required on pass-emploi realm"
}

############### APPS URLs ###############
variable "restrict_valid_redirect_uris" {
  type = bool
  default = true
  description = "Restrict redirect uri or authorize every uri"
}

############### APP SECRETS ###############
variable "app_client_secret" {
  type = string
  default = "ad7bc35e-8b11-4dff-8a6c-341158371b4e"
  sensitive = true
  description = "Client secret for app"
}
variable "app_valid_redirect_uris" {
  type = list(string)
  default = [
    "fr.fabrique.social.gouv.passemploi.staging://login-callback",
    "fr.fabrique.social.gouv.passemploi.staging://logout-callback"]
  sensitive = true
  description = "Valid redirect uris for app"
}

############### WEB SECRETS ###############
variable "web_client_secret" {
  type = string
  default = "b208225f-addd-4600-8ae5-de6e19234551"
  sensitive = true
  description = "Client secret for web"
}

variable "web_valid_redirect_uris" {
  type = list(string)
  default = [
    "http://localhost:3000/api/auth/callback/keycloak"]
  sensitive = true
  description = "Valid redirect uris for web"
}

############### IDP SECRETS ###############

############### CONSEILLERS MILO ###############
variable "idp_similo_conseiller_authorization_url" {
  type = string
  default = "https://sso-dev.i-milo.fr/auth/realms/imilo-IC-0/protocol/openid-connect/auth"
  sensitive = true
  description = "authorization_url"
}

variable "idp_similo_conseiller_token_url" {
  type = string
  default = "https://sso-dev.i-milo.fr/auth/realms/imilo-IC-0/protocol/openid-connect/token"
  sensitive = true
  description = "token_url"
}

variable "idp_similo_conseiller_logout_url" {
  type = string
  default = "https://sso-dev.i-milo.fr/auth/realms/imilo-IC-0/protocol/openid-connect/logout"
  sensitive = true
  description = "logout_url"
}

variable "idp_similo_conseiller_client_secret" {
  type = string
  default = "NO_SECRET"
  sensitive = true
  description = "client_secret"
}

############### JEUNES MILO ###############
variable "idp_similo_jeune_authorization_url" {
  type = string
  default = "https://sso-dev.i-milo.fr/auth/realms/sue-jeunes-ic0/protocol/openid-connect/auth"
  sensitive = true
  description = "authorization_url"
}

variable "idp_similo_jeune_token_url" {
  type = string
  default = "https://sso-dev.i-milo.fr/auth/realms/sue-jeunes-ic0/protocol/openid-connect/token"
  sensitive = true
  description = "token_url"
}

variable "idp_similo_jeune_logout_url" {
  type = string
  default = "https://sso-dev.i-milo.fr/auth/realms/sue-jeunes-ic0/protocol/openid-connect/logout"
  sensitive = true
  description = "logout_url"
}

variable "idp_similo_jeune_client_secret" {
  type = string
  default = "NO_SECRET"
  sensitive = true
  description = "client_secret"
}
