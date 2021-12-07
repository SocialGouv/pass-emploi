
resource "keycloak_user" "user_nils_tavernier" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Nils"
  last_name  = "Tavernier"
  email      = ""
  username   = "41"
  attributes = {
    id_user = "41",
    type = "CONSEILLER",
    structure = "PASS_EMPLOI"
  }
  initial_password {
    value = "41"
  }
}

resource "keycloak_user" "user_virginie_renoux" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Virginie"
  last_name  = "Renoux"
  email      = ""
  username   = "42"
  attributes = {
    id_user = "42",
    type = "CONSEILLER",
    structure = "PASS_EMPLOI"
  }
  initial_password {
    value = "42"
  }
}
