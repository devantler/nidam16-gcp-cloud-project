variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "name" {
  description = "name prefix for resources"
  type        = string
}

variable "image" {
  description = "container image to deploy"
  default     = "gcr.io/google-samples/zone-printer:0.2"
}