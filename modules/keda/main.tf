provider "helm" {
  kubernetes = {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "keda" {
  name       = var.release_name
  repository = "https://kedacore.github.io/charts"
  chart      = "kedacore/keda"
  version    = var.chart_version != "" ? var.chart_version : null

  create_namespace = true
  namespace        = var.namespace
  replace          = true

  values = [var.values]
}

resource "null_resource" "deploy_example" {
  count      = var.deploy_example ? 1 : 0
  depends_on = [helm_release.keda]

  provisioner "local-exec" {
    command = "kubectl apply -f ${var.manifest_path}"
  }
}
