provider "google" {
  project = var.gcp_project_id //TODO: Move project ID to a variable and find out how to use that.
}

provider "google-beta" {
  project = var.gcp_project_id //TODO: Move project ID to a variable and find out how to use that.
}

provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

terraform {
  backend "gcs" {
    bucket = "bucket-tfstate-devantler-cloud-project"
    prefix = "terraform/state"
  }
  required_providers {
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
    }
  }
}
