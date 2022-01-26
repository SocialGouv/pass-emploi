resource "keycloak_role" "pass_emploi_conseiller_superviseur_role" {
  realm_id    = keycloak_realm.pass-emploi.id
  name        = "conseiller_superviseur"
}