data "template_file" "metrics_ops_file" {
  template = chomp(file("${path.module}/templates/metrics-config-ops.yml"))
}

data "template_file" "metric_store_ops_file" {
  template = chomp(file("${path.module}/templates/metric-store-config-ops.yml"))
}