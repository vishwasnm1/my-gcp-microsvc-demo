output "name" {
  description = "The name of the cluster master. This output is used for interpolation with node pools, other modules."
  value = google_container_cluster.cluster.name
}

output "master_version" {
  description = "The Kubernetes master version."
  value       = google_container_cluster.cluster.master_version
}

output "endpoint" {
  description = "The IP address of the cluster master."
  sensitive   = true
  value       = google_container_cluster.cluster.endpoint
}
