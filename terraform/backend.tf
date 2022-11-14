# resource "google_cloud_run_service" "default" {
#   for_each = var.regions

#   name     = "backend-${each.value}"
#   location = each.value

#   template {
#     spec {
#       containers {
#         image = "gcr.io/${var.project_id}/ccecaa-backend:latest"
#       }
#     }
#   }
# }
