output "lb_name" {
  value = element(concat(azurerm_lb.iso.*.name, [""]), 0)
}

output "ssl_cert" {
  sensitive = true
  value     = length(var.ssl_ca_cert) > 0 ? element(concat(tls_locally_signed_cert.ssl_cert.*.cert_pem, [""]), 0) : var.ssl_cert
}

output "ssl_private_key" {
  sensitive = true
  value = length(var.ssl_ca_cert) > 0 ? element(
    concat(tls_private_key.ssl_private_key.*.private_key_pem, [""]),
    0,
  ) : var.ssl_private_key
}

