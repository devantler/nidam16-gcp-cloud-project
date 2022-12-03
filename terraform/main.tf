provider "google" {
  project = var.gcp_project_id //TODO: Move project ID to a variable and find out how to use that.
}

provider "google-beta" {
  project = var.gcp_project_id //TODO: Move project ID to a variable and find out how to use that.
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
