resource "google_redis_instance" "cache" {
  for_each       = toset(var.regions)
  name           = "redis-${each.value}"
  tier           = "STANDARD_HA"
  memory_size_gb = 1

  region = each.value

  #   authorized_network = data.google_compute_network.redis-network.id
}
