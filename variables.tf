variable "ssh_allowed_cidr" {
  description = "Public IP CIDR allowed to access EC2 through SSH."
  type        = string
}

variable "internal_token" {
  description = "Internal token stored in SSM Parameter Store."
  type        = string
  sensitive   = true
  ephemeral   = true
}
