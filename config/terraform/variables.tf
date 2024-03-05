variable "ssl_required" {
  type        = string
  default     = "all"
  description = "Enabled SSL required on pass-emploi realm"
}

############### CONSEILLER DEPT ###############
variable "conseiller_dept_client_secret" {
  type        = string
  default     = "b208225f-addd-4600-8ae5-de6e19234551"
  sensitive   = true
  description = "Client secret for conseiller_dept"
}

variable "conseiller_dept_valid_redirect_uris" {
  type        = list(string)
  default     = ["*"]
  sensitive   = true
  description = "Valid redirect uris for conseiller_dept"
}
