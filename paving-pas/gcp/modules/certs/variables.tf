variable "env_name" {
  default = ""
}

variable "dns_suffix" {
  default = ""
}

variable "ssl_cert" {
  default = ""
}

variable "ssl_private_key" {
  default = ""
}

variable "ssl_ca_cert" {
  default = ""
}

variable "ssl_ca_private_key" {
  default = ""
}

variable "subdomains" {
  type = list(string)
}

variable "resource_name" {
  type = string
}

