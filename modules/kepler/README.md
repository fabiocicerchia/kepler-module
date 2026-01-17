# Kepler Operator Module

Terraform module to deploy the Kepler Operator on your Kubernetes cluster for monitoring and tracking the environmental impact and power consumption.

## Features

- **Power Consumption Monitoring**: Track energy usage across your cluster
- **Environmental Impact Tracking**: Measure CO2 emissions from your workloads
- **Cert Manager**: Automatic certificate management for cluster operations
- **PowerMonitor Resources**: Optional deployment of PowerMonitor custom resources

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

### Basic Usage

```hcl
module "kepler" {
  source = "./modules/kepler"

  kubeconfig_path = "~/.kube/config"
}
```

### With Custom Namespace and Values

```hcl
module "kepler" {
  source = "./modules/kepler"

  kepler_namespace   = "custom-kepler"
  kepler_values_path = "${path.module}/custom-kepler-values.yaml"
}
```

### Disable Optional Components

```hcl
module "kepler" {
  source = "./modules/kepler"

  deploy_powermonitor = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deploy_powermonitor | Deploy the Kepler PowerMonitor resource | `bool` | `true` | no |
| kepler_namespace | Kubernetes namespace for Kepler Operator | `string` | `"kepler-operator"` | no |
| kepler_release_name | Helm release name for Kepler Operator | `string` | `"kepler-operator"` | no |
| kepler_values_path | Path to Kepler Helm values file | `string` | `"values-kepler.yaml"` | no |
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kepler_chart_version | Chart version of Kepler Operator deployment |
| kepler_namespace | Kubernetes namespace where Kepler Operator is deployed |
| kepler_release_name | Helm release name of Kepler Operator |

## Examples

### Minimal Example

```hcl
module "kepler" {
  source = "./modules/kepler"
}
```

### Complete Example

```hcl
module "kepler" {
  source = "./modules/kepler"

  kubeconfig_path = "~/.kube/config"

  kepler_namespace   = "kepler-operator"
  kepler_values_path = "${path.module}/values-kepler.yaml"

  deploy_powermonitor = true
}

output "kepler_info" {
  value = {
    namespace = module.kepler.kepler_namespace
    release   = module.kepler.kepler_release_name
    version   = module.kepler.kepler_chart_version
  }
}
```

## Notes

- Cert Manager is deployed automatically as a dependency for the Kepler Operator
- Values file should be present in your working directory unless overridden
- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- kubectl must be available in your PATH for deployment operations

## Related Resources

- [Kepler Project](https://sustainable-computing.io/)
- [Kepler Operator GitHub](https://github.com/sustainable-computing-io/kepler-operator)
- [Cert Manager](https://cert-manager.io/)

