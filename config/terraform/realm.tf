resource "keycloak_realm" "pass-emploi" {
  realm                                   = "pass-emploi"
  display_name                            = "pass-emploi"
  enabled                                 = true
  login_theme                             = "theme-pass-emploi"
  access_token_lifespan_for_implicit_flow = "5m"
  sso_session_max_lifespan                = "10h"
  sso_session_idle_timeout                = "30m"
  ssl_required                            = var.ssl_required
  #rules: hashAlgorithm specialChars passwordHistory upperCase lowerCase regexPattern digits notUsername forceExpiredPasswordChange hashIterations passwordBlacklist length
  # https://github.com/keycloak/keycloak-documentation/blob/master/server_admin/topics/authentication/password-policies.adoc
  internationalization {
    supported_locales = [
      "fr"
    ]
    default_locale = "fr"
  }
  security_defenses {
    brute_force_detection {
      permanent_lockout                = false
      max_login_failures               = 5
      wait_increment_seconds           = 60
      quick_login_check_milli_seconds  = 1000
      minimum_quick_login_wait_seconds = 60
      max_failure_wait_seconds         = 900
      failure_reset_time_seconds       = 43200
    }
  }
}
