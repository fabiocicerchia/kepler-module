# Prometheus Module

Terraform module to deploy the Prometheus monitoring stack on Kubernetes using Helm.

## Features

- **Kube Prometheus Stack**: Complete Prometheus, Grafana, and Alertmanager setup
- **Metrics Collection**: Automatic scraping of Kubernetes metrics
- **Grafana Dashboards**: Pre-configured dashboards for cluster monitoring

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster

## Usage

### Basic Usage

```hcl
module "prometheus" {
  source = "./modules/prometheus"

  kubeconfig_path = "~/.kube/config"
}
```

### With Custom Namespace and Values

```hcl
module "prometheus" {
  source = "./modules/prometheus"

  prometheus_namespace   = "custom-monitoring"
  prometheus_values_path = "${path.module}/custom-values.yaml"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| prometheus_namespace | Kubernetes namespace for Prometheus | `string` | `"monitoring"` | no |
| prometheus_release_name | Helm release name for Prometheus | `string` | `"prometheus-community"` | no |
| prometheus_values_path | Path to Prometheus Helm values file | `string` | `"values-prometheus.yaml"` | no |

## Outputs

| Name | Description |
|------|-------------|
| prometheus_chart_version | Chart version of Prometheus deployment |
| prometheus_namespace | Kubernetes namespace where Prometheus is deployed |
| prometheus_release_name | Helm release name of Prometheus |

## Notes

- Values file should be present in your working directory unless overridden
- The Helm provider requires access to your Kubernetes cluster via kubeconfig

## Related Resources

- [Prometheus Operator](https://prometheus-operator.dev/)
- [Kube Prometheus Stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack)
