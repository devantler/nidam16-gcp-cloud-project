provider "mongodbatlas" {
  public_key  = var.mongodb_atlas_public_key
  private_key = var.mongodb_atlas_private_key
}

resource "mongodbatlas_cluster" "test" {
  project_id   = var.mongodb_project_id
  name         = "mongodb-cluster"
  cluster_type = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = "CENTRAL_US"
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }

  provider_name               = "TENANT"
  backing_provider_name       = "GCP"
  provider_region_name        = "CENTRAL_US"
  provider_instance_size_name = "M0"
}
