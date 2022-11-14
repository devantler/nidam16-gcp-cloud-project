terraform {
  cloud {
    organization = "ccecaa-cloud"

    workspaces {
      name = "cloud-project-production"
    }
  }
}

provider "google" {
  project = "formal-vertex-364508" //TODO: Move project ID to a variable and find out how to use that.
  credentials = var.gcp_credentials
}

resource "google_cloud_run_service" "default" {
  for_each = toset(var.regions)

  name     = "frontend-${each.value}"
  location = each.value

  template {
    spec {
      containers {
        image = "gcr.io/formal-vertex-364508/ccecaa-frontend:latest"
      }
    }
  }
}

/*resource "google_cloud_run_service" "default" {
  for_each = var.regions

  name     = "backend-${each.value}"
  location = each.value

  template {
    spec {
      containers {
        image = "gcr.io/formal-vertex-364508/ccecaa-backend:latest"
      }
    }
  }
}*/

# resource "google_cloud_run_service_iam_member" "default" {
#   for_each = toset(data.google_cloud_run_locations.default.locations)

#   location = google_cloud_run_service.default[each.key].location
#   project  = google_cloud_run_service.default[each.key].project
#   service  = google_cloud_run_service.default[each.key].name
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }


# resource "google_compute_region_network_endpoint_group" "default" {
#   for_each = toset(data.google_cloud_run_locations.default.locations)

#   name                  = "${var.name}--neg--${each.key}"
#   network_endpoint_type = "SERVERLESS"
#   region                = google_cloud_run_service.default[each.key].location
#   cloud_run {
#     service = google_cloud_run_service.default[each.key].name
#   }
# }

# module "lb-http" {
#   source            = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
#   version           = "~> 6.0"

#   project = var.project_id
#   name    = var.name

#   ssl                             = false
#   managed_ssl_certificate_domains = []
#   https_redirect                  = false
#   backends = {
#     default = {
#       description            = null
#       enable_cdn             = false
#       custom_request_headers = null

#       log_config = {
#         enable      = true
#         sample_rate = 1.0
#       }

#       groups = [
#         for neg in google_compute_region_network_endpoint_group.default:
#         {
#           group = neg.id
#         }
#       ]

#       iap_config = {
#         enable               = false
#         oauth2_client_id     = null
#         oauth2_client_secret = null
#       }
#       security_policy = null
#     }
#   }
# }

/*output "url" {
  value = "http://${module.lb-http.external_ip}"
}*/
