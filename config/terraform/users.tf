resource "keycloak_user" "user_conseiller_zema" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Conseiller"
  last_name  = "Dépt"
  email      = "zema@octo.com"
  username   = "zema@octo.com"
  attributes = {
    id_user   = "zema@octo.com",
    type      = "CONSEILLER",
    structure = "CONSEILLER_DEPT"
  }
  initial_password {
    value = "zema"
  }
}
resource "keycloak_user" "user_conseiller_jopa" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Conseiller"
  last_name  = "Dépt"
  email      = "jopa@octo.com"
  username   = "jopa@octo.com"
  attributes = {
    id_user   = "jopa@octo.com",
    type      = "CONSEILLER",
    structure = "CONSEILLER_DEPT"
  }
  initial_password {
    value = "jopa"
  }
}
