variable "project" {
  type = string
}

variable "env_name" {
  default = ""
}

variable "region" {
  default = ""
}

variable "pas_cidr" {
  type = string
}

variable "services_cidr" {
  type = string
}

variable "network" {
  type = string
}

variable "internetless" {
}

variable "dns_zone_dns_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "global_lb" {
}

variable "zones" {
  type = list(string)
}

variable "create_gcs_buckets" {
}

variable "buckets_location" {
}

variable "ssl_certificate" {
  type = string
}

variable "external_database" {
  default = false
}

variable "sql_instance" {
  default = ""
}

variable "pas_sql_db_host" {
  default = ""
}

variable "isoseg_lb_name" {
  default = ""
}

