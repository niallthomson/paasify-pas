locals {
  external_db_count = var.external_database ? 1 : 0
}

resource "google_sql_database" "opsman" {
  name       = var.env_name
  instance   = var.sql_instance
  depends_on = [google_sql_user.opsman]

  count = local.external_db_count
}

resource "random_id" "opsman_db_username" {
  byte_length = 8

  count = local.external_db_count
}

resource "random_id" "opsman_db_password" {
  byte_length = 32

  count = local.external_db_count
}

resource "google_sql_user" "opsman" {
  name     = random_id.opsman_db_username[0].b64
  password = random_id.opsman_db_password[0].b64
  instance = var.sql_instance
  host     = var.opsman_sql_db_host

  count = local.external_db_count
}

