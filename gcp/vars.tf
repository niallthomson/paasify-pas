variable "env_name" {
  description = "The name of the environment, used to name resources and DNS domains"
  type        = string
}

variable "project" {
  description = "The GCP project to use for deploying the foundation"
}

variable "vpc_cidr" {
  description = "The CIDR of the AWS VPC that will be created for this foundation"
  type        = string
  default     = "10.0.0.0/20"
}

variable "region" {
  description = "The GCP region in which to deploy the foundation (ie. us-central1)"
  type        = string
}

variable "dns_suffix" {
  description = "The suffix of the DNS domain that will be used (ie. aws.paasify.org)"
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the Cloud DNS zone that managed the domain specified for dns_suffix"
  type        = string
}

variable "availability_zones" {
  description = "List of GCP availability zones in which to deploy the foundation"
  type        = list(string)
}

variable "pivnet_token" {
  description = "Token for Pivotal Network used to download assets"
  type        = string
}

variable "ops_manager_instance_type" {
  description = "GCP instance type used for OpsManager"
  type        = string
  default     = "n1-standard-2"
}

variable "pas_version" {
  description = "The major version of PAS to install (ie. 2.8)"
  type        = string
}

variable "tiles" {
  description = "List of names of tiles to install with PAS"
  type        = list(string)
  default     = []
}

variable "buckets_location" {
  type    = string
  default = "US"
}

variable "auto_apply" {
  description = "Enable or disable automatically running Apply Changes"
  default     = true
  type        = bool
}

variable "skip_smoke_tests" {
  description = "Skip smoke test errands for all tiles (faster deployment)"
  default     = false
  type        = bool
}