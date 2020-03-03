variable "iaas" {

}

variable "availability_zones" {
  type = list
}

variable "az_configuration" {

}

variable "singleton_az" {

}

variable "tls_cert" {

}

variable "tls_private_key" {

}

variable "tls_ca_cert" {

}

variable "additional_config" {
  default = ""
}

variable "apps_domain" {

}

variable "sys_domain" {

}

variable "compute_instances" {
  default = 1
}

variable "web_elb_names" {
  type = list
}

variable "ssh_elb_names" {
  type = list
}

variable "pas_ops_file" {
  type    = string
  default = "---"
}

variable "provisioner_host" {
  description = "The host of the paasify provisioner used to trigger the install the tile"
}

variable "provisioner_ssh_username" {
  description = "The host of the paasify provisioner used to trigger the install the tile"
}

variable "provisioner_ssh_private_key" {
  description = "The SSH private key of the paasify provisioner"
}

variable "pas_version" {
  description = "The major version of PAS to install"
}

variable "tiles" {
  type    = list
  default = []
}

variable "auto_apply" {
  default = true
  type    = bool
}

variable "blocker" {

}