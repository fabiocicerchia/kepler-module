# GreenOps Module

Comprehensive Terraform module for deploying a complete green operations monitoring stack on Kubernetes. Includes Prometheus, KEDA, OpenCost, and Kepler Operator with individual toggles for selective component deployment.

## Features

- **Selective Deployment**: Enable or disable components individually via feature toggles
- **Prometheus Monitoring**: Complete monitoring and metrics stack
- **KEDA Autoscaling**: Event-driven workload scaling
- **OpenCost**: Cloud cost monitoring and allocation
- **Kepler Operator**: Environmental impact and power consumption tracking
- **Flexible Configuration**: Customize each component independently

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| helm | >= 2.0 |
| null | >= 3.0 |

### External Requirements

- [kubectl](https://kubernetes.io/docs/tasks/tools/) - For interacting with your Kubernetes cluster
- [Kubernetes cluster](https://kubernetes.io/docs/setup/) - A running Kubernetes cluster

## Usage

### Deploy All Components (Default)

```hcl
module "greenops" {
  source = "./modules/greenops"
}
```

### Deploy Specific Components

```hcl
module "greenops" {
  source = "./modules/greenops"

  enable_prometheus = true
  enable_keda       = false
  enable_opencost   = true
  enable_kepler     = true
}
```

### Custom Configuration

```hcl
module "greenops" {
  source = "./modules/greenops"

  kubeconfig_path = "~/.kube/config"

  enable_prometheus      = true
  prometheus_namespace   = "custom-monitoring"
  prometheus_values_path = "${path.module}/custom-prometheus.yaml"

  enable_keda      = true
  keda_namespace   = "custom-keda"

  enable_opencost      = true
  opencost_namespace   = "cost-tracking"
  opencost_values_path = "${path.module}/custom-opencost.yaml"

  enable_kepler    = true
  kepler_namespace = "sustainability"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| enable_prometheus | Enable Prometheus monitoring stack deployment | `bool` | `true` | no |
| enable_keda | Enable KEDA event-driven autoscaling deployment | `bool` | `true` | no |
| enable_opencost | Enable OpenCost cost monitoring deployment | `bool` | `true` | no |
| enable_kepler | Enable Kepler Operator deployment | `bool` | `true` | no |
| prometheus_release_name | Helm release name for Prometheus | `string` | `"prometheus-community"` | no |
| prometheus_namespace | Kubernetes namespace for Prometheus | `string` | `"monitoring"` | no |
| prometheus_values_path | Path to Prometheus Helm values file | `string` | `"values-prometheus.yaml"` | no |
| keda_release_name | Helm release name for KEDA | `string` | `"kedacore"` | no |
| keda_namespace | Kubernetes namespace for KEDA | `string` | `"keda"` | no |
| deploy_keda_example | Deploy KEDA example manifests | `bool` | `true` | no |
| keda_manifest_path | Path to KEDA manifest file | `string` | `"keda.yaml"` | no |
| opencost_release_name | Helm release name for OpenCost | `string` | `"opencost-charts"` | no |
| opencost_namespace | Kubernetes namespace for OpenCost | `string` | `"opencost"` | no |
| opencost_values_path | Path to OpenCost Helm values file | `string` | `"values-opencost.yaml"` | no |
| kepler_release_name | Helm release name for Kepler Operator | `string` | `"kepler-operator"` | no |
| kepler_namespace | Kubernetes namespace for Kepler Operator | `string` | `"kepler-operator"` | no |
| kepler_values_path | Path to Kepler Helm values file | `string` | `"values-kepler.yaml"` | no |
| deploy_powermonitor | Deploy the Kepler PowerMonitor resource | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| prometheus | Prometheus module outputs (namespace, release, version) |
| keda | KEDA module outputs (namespace, release, version) |
| opencost | OpenCost module outputs (namespace, release, version) |
| kepler | Kepler module outputs (namespace, release, version) |
| deployed_components | Map of deployed component flags |

## Examples

### Minimal Example

```hcl
module "greenops" {
  source = "./modules/greenops"
}
```

### Production Example

```hcl
module "greenops" {
  source = "./modules/greenops"

  kubeconfig_path = "~/.kube/config"

  enable_prometheus = true
  enable_keda       = true
  enable_opencost   = true
  enable_kepler     = true

  prometheus_namespace = "monitoring"
  keda_namespace       = "keda"
  opencost_namespace   = "opencost"
  kepler_namespace     = "kepler"

  deploy_powermonitor = true
}

output "greenops_status" {
  value = {
    components = module.greenops.deployed_components
    prometheus = module.greenops.prometheus
    keda       = module.greenops.keda
    opencost   = module.greenops.opencost
    kepler     = module.greenops.kepler
  }
}
```

## Notes

- All components are enabled by default; disable selectively as needed
- Each component uses its respective Helm values file from the working directory
- kubectl must be available in your PATH for manifest deployments
- The Helm provider requires access to your Kubernetes cluster via kubeconfig

## Related Resources

- [Prometheus Operator](https://prometheus-operator.dev/)
- [KEDA Documentation](https://keda.sh/)
- [OpenCost Project](https://www.opencost.io/)
- [Kepler Project](https://sustainable-computing.io/)
