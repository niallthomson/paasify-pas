resource "aws_s3_bucket" "buildpacks_bucket" {
  bucket        = "${var.env_name}-buildpacks-bucket-${module.pave.bucket_suffix}"
  force_destroy = true

  tags = {
    "Name" = "Elastic Runtime S3 Buildpacks Bucket"
  }
}

resource "aws_s3_bucket" "droplets_bucket" {
  bucket        = "${var.env_name}-droplets-bucket-${module.pave.bucket_suffix}"
  force_destroy = true

  tags = {
    "Name" = "Elastic Runtime S3 Droplets Bucket"
  }
}

resource "aws_s3_bucket" "packages_bucket" {
  bucket        = "${var.env_name}-packages-bucket-${module.pave.bucket_suffix}"
  force_destroy = true

  tags = {
    "Name" = "Elastic Runtime S3 Packages Bucket"
  }
}

resource "aws_s3_bucket" "resources_bucket" {
  bucket        = "${var.env_name}-resources-bucket-${module.pave.bucket_suffix}"
  force_destroy = true

  tags = {
    "Name" = "Elastic Runtime S3 Resources Bucket"
  }
}