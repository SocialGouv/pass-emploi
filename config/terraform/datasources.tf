data "keycloak_openid_client" "realm_management" {
  realm_id  = keycloak_realm.pass-emploi.id
  client_id = "realm-management"
}

data "keycloak_role" "view_users" {
  realm_id  = keycloak_realm.pass-emploi.id
  client_id = data.keycloak_openid_client.realm_management.id
  name      = "view-users"
}
