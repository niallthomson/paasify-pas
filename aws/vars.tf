variable "env_name" {

}

variable "vpc_cidr" {
  default = "10.0.0.0/20"
}

variable "region" {

}

variable "dns_suffix" {

}

variable "availability_zones" {
  description = "Optional list of availability zones, will be chosen automatically otherwise"
  type        = list(string)
  default     = []
}

variable "pivnet_token" {
  
}

variable "ops_manager_instance_type" {
  default = "r4.large"
}

variable "tiles" {
  type = "list"
  default = []
}

variable "encrypt_pas_buckets" {
  default = "1"
}