# TODO: Enabled S3 encryption for filestore
data "template_file" "pas_ops_file" {
  template = "${chomp(file("${path.module}/templates/pas-config-ops.yml"))}"

  vars = {
    region               = var.region
    access_key           = aws_iam_access_key.pas_buckets.id
    secret_key           = aws_iam_access_key.pas_buckets.secret
    
    droplets_bucket      = module.infra.pas_droplets_bucket
    packages_bucket      = module.infra.pas_packages_bucket
    buildpacks_bucket    = module.infra.pas_buildpacks_bucket
    resources_bucket     = module.infra.pas_resources_bucket
    bucket_encryption    = var.encrypt_pas_buckets
    kms_id               = var.encrypt_pas_buckets == "1" ? module.infra.blobstore_kms_key_id : ""

    web_lb_extensions    = "web_lb_security_groups"
    ssh_lb_extensions    = "ssh_lb_security_groups"
  }
}