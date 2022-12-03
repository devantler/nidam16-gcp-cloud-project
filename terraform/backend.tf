resource "google_cloud_run_service" "backend" {
  for_each = toset(var.regions)

  name     = "backend-${each.value}"
  location = each.value

  template {
    spec {
      containers {
        image = "gcr.io/${var.gcp_project_id}/ccecaa-backend:latest"
        ports {
          container_port = 3000
        }
        dynamic "env" {
          for_each = var.backend_env
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "backend" {
  for_each = toset(var.regions)

  location = google_cloud_run_service.backend[each.key].location
  project  = google_cloud_run_service.backend[each.key].project
  service  = google_cloud_run_service.backend[each.key].name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_compute_region_network_endpoint_group" "backend" {
  provider = google-beta
  for_each = toset(var.regions)

  name                  = "neg-${each.key}"
  network_endpoint_type = "SERVERLESS"
  region                = google_cloud_run_service.backend[each.key].location
  cloud_run {
    service = google_cloud_run_service.backend[each.key].name
  }
}
