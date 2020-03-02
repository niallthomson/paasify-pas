resource "google_storage_bucket" "buildpacks" {
  name          = "${var.project}-${var.env_name}-buildpacks"
  location      = var.buckets_location
  force_destroy = true
}

resource "google_storage_bucket" "droplets" {
  name          = "${var.project}-${var.env_name}-droplets"
  location      = var.buckets_location
  force_destroy = true
}

resource "google_storage_bucket" "packages" {
  name          = "${var.project}-${var.env_name}-packages"
  location      = var.buckets_location
  force_destroy = true
}

resource "google_storage_bucket" "resources" {
  name          = "${var.project}-${var.env_name}-resources"
  location      = var.buckets_location
  force_destroy = true
}

resource "google_storage_bucket" "backup" {
  name          = "${var.project}-${var.env_name}-backup"
  location      = var.buckets_location
  force_destroy = true
}