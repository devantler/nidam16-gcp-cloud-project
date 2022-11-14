variable "gcp_credentials" {
  type = string
  sensitive = true
  description = "Google Cloud service account credentials"
}

variable "regions" {
  type = list(string)
  default = ["us-central1"]
}
