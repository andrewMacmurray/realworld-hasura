resource "random_password" "admin_secret" {
  length  = 64
  special = true
}

resource "random_password" "jwt_secret" {
  length  = 64
  special = true
}

resource "random_password" "actions_secret" {
  length  = 64
  special = true
}