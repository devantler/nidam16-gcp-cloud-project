provider "google" {
  project = var.project_id //TODO: Move project ID to a variable and find out how to use that.
}

provider "google-beta" {
  project = var.project_id //TODO: Move project ID to a variable and find out how to use that.
}

terraform {
  backend "gcs" {
    bucket = "f3c2369c2f1ea89d-bucket-tfstate"
    prefix = "terraform/state"
  }
}