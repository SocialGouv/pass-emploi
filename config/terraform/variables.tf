variable "ssl_required" {
  type        = string
  default     = "all"
  description = "Enabled SSL required on pass-emploi realm"
}

############### APPS URLs ###############
variable "restrict_valid_redirect_uris" {
  type        = bool
  default     = true
  description = "Restrict redirect uri or authorize every uri"
}

############### CLIENT SECRETS ###############
variable "fdg-api-client-secret" {
  type        = string
  default     = "fdg-api"
  sensitive   = true
  description = "Client secret for fdg api"
}

