resource "google_cloud_run_service" "frontend" {
  for_each = toset(var.regions)

  name                       = "frontend-${each.value}"
  autogenerate_revision_name = true
  location                   = each.value

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/ccecaa-frontend:latest"
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

module "lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 6.0"

  project = var.project_id
  name    = "lb-cloud-project"

  ssl                             = false
  managed_ssl_certificate_domains = []
  https_redirect                  = false
  backends = {
    default = {
      description             = null
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        for neg in google_compute_region_network_endpoint_group.frontend :
        {
          group = neg.id
        }
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
      security_policy = null
    }
  }
}

output "url" {
  value = "http://${module.lb-http.external_ip}"
}
