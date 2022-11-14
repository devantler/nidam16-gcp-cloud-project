
variable "project_id" {
  description = "The ID of the project in which the resource belongs. The project must be a billing account project."
  type        = string
  default     = "formal-vertex-364508"
}

variable "regions" {
  type = list(string)
  default = ["us-central1"]
}
