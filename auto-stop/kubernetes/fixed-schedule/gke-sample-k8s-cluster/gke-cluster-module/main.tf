resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  network    = var.network
  subnetwork = var.subnetwork

  #remove_default_node_pool = true
  # initial_node_count       = 1
  deletion_protection      = false

  ip_allocation_policy {}

  node_pool {
    name       = "primary-node-pool"
    node_count = 1
    node_config {
      machine_type = "e2-standard-2"
      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]
    }
  }
}
#
# resource "google_container_node_pool" "primary_nodes" {
#   name       = "primary-node-pool"
#   cluster    = google_container_cluster.primary.name
#   location   = var.region
#   node_count = 1
#
#   node_config {
#     machine_type = "e2-standard-2"
#     oauth_scopes = [
#       "https://www.googleapis.com/auth/cloud-platform"
#     ]
#   }
# }
