locals {
  app_domain = "apps.${module.pave.base_domain}"
  sys_domain = "sys.${module.pave.base_domain}"
}

resource "aws_route53_record" "wildcard_sys_dns" {
  zone_id = module.pave.dns_zone_id
  name    = "*.${local.sys_domain}"
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wildcard_apps_dns" {
  zone_id = module.pave.dns_zone_id
  name    = "*.${local.app_domain}"
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssh" {
  zone_id = module.pave.dns_zone_id
  name    = "ssh.${local.sys_domain}"
  type    = "A"

  alias {
    name                   = aws_lb.ssh.dns_name
    zone_id                = aws_lb.ssh.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "tcp" {
  zone_id = module.pave.dns_zone_id
  name    = "tcp.${module.pave.base_domain}"
  type    = "A"

  alias {
    name                   = aws_lb.tcp.dns_name
    zone_id                = aws_lb.tcp.zone_id
    evaluate_target_health = true
  }
}