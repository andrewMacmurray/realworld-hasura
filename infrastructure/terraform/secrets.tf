resource "random_password" "admin_secret" {
  length  = 64
  special = false
}

resource "random_password" "jwt_secret" {
  length  = 64
  special = true
}

resource "random_password" "actions_secret" {
  length  = 64
  special = true
}

variable "database_password" {
  type = string
}

variable "database_username" {
  type = string
}

variable "database_host" {
  type = string
}

variable "database_port" {
  type = string
}