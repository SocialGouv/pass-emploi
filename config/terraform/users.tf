
resource "keycloak_user" "user_nils_tavernier" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Nils"
  last_name  = "Tavernier"
  email      = ""
  username   = "1"
  initial_password {
    value = "1"
  }
}

resource "keycloak_user" "user_virginie_renoux" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Virginie"
  last_name  = "Renoux"
  email      = ""
  username   = "2"
  initial_password {
    value = "2"
  }
}
