module "lb-http" {
  source  = "GoogleCloudPlatform/lb-http/google//modules/serverless_negs"
  version = "~> 7.0"

  project = var.gcp_project_id
  name    = "lb-cloud-project"

  ssl                             = true
  managed_ssl_certificate_domains = ["www.nda-cloud.com"]
  https_redirect                  = true
  
  backends = {
    default = {
      description             = null
      enable_cdn              = true
      custom_request_headers  = null
      custom_response_headers = null

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        for neg in merge(google_compute_region_network_endpoint_group.frontend) :
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

# output "url" {
#   value = "https://${module.lb-http.external_ip}"
# }
