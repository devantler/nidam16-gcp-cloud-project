provider "google" {
  project = "annular-text-370515" //Remember to change this to your project ID.
}

resource "google_storage_bucket" "default" {
  name          = "bucket-tfstate-devantler-cloud-project"
  force_destroy = false
  location      = "us-central1"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}
