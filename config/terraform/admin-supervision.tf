resource "keycloak_role" "pass_emploi_admin_supervision_role" {
  realm_id        = keycloak_realm.pass-emploi.id
  name            = "admin_supervision"
  composite_roles = [
    data.keycloak_role.view_users.id
  ]
}

resource "keycloak_role" "pass_emploi_conseiller_superviseur_role" {
  realm_id = keycloak_realm.pass-emploi.id
  name     = "conseiller_superviseur"
}

resource "keycloak_user" "user_admin_supervision" {
  realm_id   = keycloak_realm.pass-emploi.id
  enabled    = true
  first_name = "Supervision"
  last_name  = "Admin"
  email      = ""
  username   = "admin_supervision"
  initial_password {
    value = "admin_supervision"
  }
}

resource "keycloak_user_roles" "user_admin_supervision_roles" {
  realm_id = keycloak_realm.pass-emploi.id
  user_id  = keycloak_user.user_admin_supervision.id

  role_ids = [
    keycloak_role.pass_emploi_admin_supervision_role.id
  ]
}

resource "keycloak_openid_client_permissions" "realm_management_permission" {
  realm_id  = keycloak_realm.pass-emploi.id
  client_id = data.keycloak_openid_client.realm_management.id
}

resource "keycloak_openid_client_role_policy" "admin_supervision" {
  realm_id           = keycloak_realm.pass-emploi.id
  resource_server_id = data.keycloak_openid_client.realm_management.id
  name               = "realm_role_policy_admin_supervision"
  type               = "role"
  logic              = "POSITIVE"
  decision_strategy  = "UNANIMOUS"
  depends_on         = [
    keycloak_openid_client_permissions.realm_management_permission,
  ]
  role {
    id       = keycloak_role.pass_emploi_admin_supervision_role.id
    required = true
  }
}

resource "keycloak_users_permissions" "users_permissions" {
  realm_id = keycloak_realm.pass-emploi.id

  map_roles_scope {
    policies          = [
      keycloak_openid_client_role_policy.admin_supervision.id
    ]
    description       = "description"
    decision_strategy = "UNANIMOUS"
  }
}

###
# Il n'existe pas encore de resource pour affecter des permissions spécifiquement à un rôle,
# Il faut donc le faire manuellement dans la console d'admin
###

#resource "keycloak_role_permissions" "conseiller_supervision_permissions" {
#  realm_id = keycloak_realm.pass-emploi.id
#  role_id  = keycloak_role.pass_emploi_conseiller_superviseur_role.id
#  map_roles_scope {
#    policies          = [
#      keycloak_openid_client_role_policy.admin_supervision.id
#    ]
#    description       = "description"
#    decision_strategy = "UNANIMOUS"
#  }
#}
