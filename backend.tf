locals {
  bucket = "foo-bucket"
}
terraform {
  backend "gcs" {
    bucket = local.bucket
    prefix = "terraform/${local.bucket}/state"
  }
}
