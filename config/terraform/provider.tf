terraform {
  required_providers {
    keycloak = {
      source = "mrparkers/keycloak"
      version = "3.6.0"
    }
  }
}

provider "keycloak" {
  client_timeout           = 10
  tls_insecure_skip_verify = true
}
