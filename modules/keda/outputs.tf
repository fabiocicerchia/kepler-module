output "namespace" {
  description = "Kubernetes namespace where KEDA is deployed"
  value       = helm_release.keda.namespace
}

output "release_name" {
  description = "Helm release name of KEDA"
  value       = helm_release.keda.name
}

output "chart_version" {
  description = "Chart version of KEDA deployment"
  value       = helm_release.keda.version
}
