variable "project_id" {
  description = "The ID of the project in which the resource belongs. The project must be a billing account project."
  type        = string
  default     = "annular-text-370515"
}

variable "tfstate_bucket_name" { // Remember to set your bucket name here, and in the main.tf backend "gcs".
  description = "The name of the bucket to store the Terraform state in."
  type        = string
  default     = "bucket-tfstate-nda-cloud-project"
}

variable "regions" {
  type    = list(string)
  default = ["us-central1"]
}

# variable "zones" {
#   type    = list(string)
#   default = ["us-central1-a"]
# }


variable "frontend_env" {
  description = "The environment of the frontend."
  type = list(object({
    name = string
    value = string
  }))
  default = []
}

variable "backend_env" {
  description = "The environment of the backend."
  type = list(object({
    name = string
    value = string
  }))
  default = []
}
