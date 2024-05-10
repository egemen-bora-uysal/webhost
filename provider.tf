terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.63.1"
    }
    kubernetes = {
      version = "~> 2.16"
      source  = "hashicorp/kubernetes"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}
