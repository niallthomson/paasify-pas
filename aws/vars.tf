variable "env_name" {
  description = "The name of the environment, used to name resources and DNS domains"
}

variable "vpc_cidr" {
  description = "The CIDR of the AWS VPC that will be created for this foundation"
  default     = "10.0.0.0/20"
}

variable "region" {
  description = "The AWS region in which to deploy the foundation (ie. us-west-2)"
}

variable "dns_suffix" {
  description = "The suffix of the DNS domain that will be used (ie. aws.paasify.org)"
}

variable "availability_zones" {
  description = "List of AWS availability zones in which to deploy the foundation"
  type        = list(string)
}

variable "pivnet_token" {
  description = "Token for Pivotal Network used to download assets"
}

variable "ops_manager_instance_type" {
  description = "AWS EC2 instance type used for OpsManager"
  default     = "r4.large"
}

variable "pas_version" {
  description = "The major version of PAS to install (ie. 2.8)"
}

variable "tiles" {
  description = "List of names of tiles to install with PAS"
  type        = list(string)
  default     = []
}

variable "encrypt_pas_buckets" {
  description = "Apply KMS encryption to S3 buckets used for PAS"
  default     = "1"
}