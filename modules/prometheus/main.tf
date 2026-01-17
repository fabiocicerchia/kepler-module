provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "prometheus_community" {
  name       = var.release_name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-community/kube-prometheus-stack"

  create_namespace = true
  namespace        = var.namespace
  replace          = true

  values = [var.values]
}
