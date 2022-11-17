resource "google_cloud_run_service" "frontend" {
  for_each = toset(var.regions)

  name                       = "frontend-${each.value}"
  autogenerate_revision_name = true
  location                   = each.value

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/ccecaa-frontend:latest"
        dynamic "env" {
          for_each = var.frontend_env
          content {
            name  = env.value["name"]
            value = env.value["value"]
          }
        }
      }
    }
  }
}

resource "google_cloud_run_service_iam_member" "frontend" {
  for_each = toset(var.regions)

  location = google_cloud_run_service.frontend[each.key].location
  project  = google_cloud_run_service.frontend[each.key].project
  service  = google_cloud_run_service.frontend[each.key].name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_compute_region_network_endpoint_group" "frontend" {
  provider = google-beta
  for_each = toset(var.regions)

  name                  = "neg-${each.key}"
  network_endpoint_type = "SERVERLESS"
  region                = google_cloud_run_service.frontend[each.key].location
  cloud_run {
    service = google_cloud_run_service.frontend[each.key].name
  }
}