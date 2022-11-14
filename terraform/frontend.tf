resource "google_cloud_run_service" "default" {
  for_each = toset(var.regions)

  name     = "frontend-${each.value}"
  location = each.value

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/ccecaa-frontend:latest"
      }
    }
  }
}
