module "pas_network_config" {
  source = "github.com/niallthomson/paasify-core//build-network-config/aws"

  vpc_cidr      = module.pave.vpc_cidr
  subnet_ids    = aws_subnet.pas_subnets.*.id
  subnet_cidrs  = aws_subnet.pas_subnets.*.cidr_block
  subnet_azs    = aws_subnet.pas_subnets.*.availability_zone
}

module "services_network_config" {
  source = "github.com/niallthomson/paasify-core//build-network-config/aws"

  vpc_cidr      = module.pave.vpc_cidr
  subnet_ids    = aws_subnet.services_subnets.*.id
  subnet_cidrs  = aws_subnet.services_subnets.*.cidr_block
  subnet_azs    = aws_subnet.services_subnets.*.availability_zone
}

data "template_file" "director_ops_file" {
  template = "${chomp(file("${path.module}/templates/director-ops-file.yml"))}"

  vars = {
    pas_subnets        = module.pas_network_config.subnet_config
    services_subnets   = module.services_network_config.subnet_config
    env_name           = var.env_name
    vms_security_group = module.pave.vms_security_group_name
  }
}