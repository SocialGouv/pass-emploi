
resource "keycloak_user" "user_toto" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "toto"
  last_name  = "tata"
  email      = ""
  username   = "toto"
  initial_password {
    value = "Motdepasse1."
  }
}
