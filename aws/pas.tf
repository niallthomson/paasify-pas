# TODO: Enabled S3 encryption for filestore
data "template_file" "pas_ops_file" {
  template = "${chomp(file("${path.module}/templates/pas-config-ops.yml"))}"

  vars = {
    region     = var.region
    access_key = aws_iam_access_key.pas.id
    secret_key = aws_iam_access_key.pas.secret

    droplets_bucket   = aws_s3_bucket.droplets_bucket.bucket
    packages_bucket   = aws_s3_bucket.packages_bucket.bucket
    buildpacks_bucket = aws_s3_bucket.buildpacks_bucket.bucket
    resources_bucket  = aws_s3_bucket.resources_bucket.bucket
    bucket_encryption = var.encrypt_pas_buckets
    kms_id            = var.encrypt_pas_buckets == "1" ? aws_kms_key.blobstore_kms_key.id : ""

    web_lb_extensions = "web_lb_security_groups"
    ssh_lb_extensions = "ssh_lb_security_groups"
  }
}