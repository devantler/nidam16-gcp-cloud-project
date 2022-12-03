variable "gcp_project_id" {
  description = "The ID of the project in which the resource belongs. The project must be a billing account project."
  type        = string
  default     = "annular-text-370515"
}

variable "mongodb_project_id" {
  description = "The ID of the project in which the resource belongs. The project must be a billing account project."
  type        = string
  default     = "638b6dc8d69a6253659af386"
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

variable "frontend_env" {
  description = "The environment of the frontend."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "backend_env" {
  description = "The environment of the backend."
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "MONGO_DB_CONNECTION_STRING"
      value = "mongodb+srv://devantler:OUFbpEDdIBoxXhrg@mongodb-cluster.pgwscm0.mongodb.net/?retryWrites=true&w=majority"
    },
    {
      name = "MONGO_DB_NAME"
      value = "devantler"
    },
    {
      name = "REDIS_URI"
      value = "redis://10.129.10.100:6379"
    },
    {
      name = "NODE_ENV"
      value = "production"
    }
  ]
}

variable "mongodb_atlas_public_key" {
  description = "The public key of the MongoDB Atlas account."
  type        = string
  default     = "yviljlse"
}

variable "mongodb_atlas_private_key" {
  description = "The private key of the MongoDB Atlas account."
  type        = string
  default     = "317701c2-d704-468d-80c6-bf8f3854a50c"
}
