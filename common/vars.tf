variable "iaas" {

}

variable "availability_zones" {
  type    = list
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
  type    = list
}

variable "ssh_elb_names" {
  type    = list
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

variable "ops_manager_versions" {
  default = {
    2.6 = {
      version = "2.6.22"
      build   = "288"
    }

    2.7 = {
      version = "2.7.12"
      build   = "260"
    }

    2.8 = {
      version = "2.8.2"
      build   = "203"
    }
  }
}

variable "tile_versions" {
  default = {
    2.8 = {
      pas         = "2.8.1"
      mysql       = "2.7.5"
      redis       = "2.2.1"
      rabbit      = "1.18.3"
      scs         = "3.0.5"
      metrics     = "1.6.1"
      healthwatch = "1.8.0"
      pcc         = "1.8.0"
      credhub     = "1.3.2"
      scdf        = "1.6.1"
      antivirus   = "2.1.6"
      gateway     = "1.0.0"
      fim         = "2.0.0"
      sso         = "1.11.0"
    }
  }
}

variable "tiles" {
  type = list
  default = []
}

variable "blocker" {

}