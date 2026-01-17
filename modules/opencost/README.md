# OpenCost Module

Terraform module to deploy OpenCost on your Kubernetes cluster for cost monitoring and allocation.

## Features

- **Cost Monitoring**: Track and allocate cloud resource costs within your Kubernetes cluster
- **Multi-Cloud Support**: Works with AWS, Azure, GCP, and on-premises clusters
- **Resource Allocation**: Detailed cost breakdown by namespace, pod, and label

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
module "opencost" {
  source = "./modules/opencost"

  kubeconfig_path = "~/.kube/config"
}
```

### With Custom Namespace and Values

```hcl
module "opencost" {
  source = "./modules/opencost"

  opencost_namespace   = "cost-monitoring"
  opencost_values_path = "${path.module}/custom-opencost-values.yaml"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| opencost_namespace | Kubernetes namespace for OpenCost | `string` | `"opencost"` | no |
| opencost_release_name | Helm release name for OpenCost | `string` | `"opencost-charts"` | no |
| opencost_values_path | Path to OpenCost Helm values file | `string` | `"values-opencost.yaml"` | no |

## Outputs

| Name | Description |
|------|-------------|
| opencost_chart_version | Chart version of OpenCost deployment |
| opencost_namespace | Kubernetes namespace where OpenCost is deployed |
| opencost_release_name | Helm release name of OpenCost |

## Notes

- Values file should be present in your working directory unless overridden
- The Helm provider requires access to your Kubernetes cluster via kubeconfig

## Related Resources

- [OpenCost Project](https://www.opencost.io/)
- [OpenCost GitHub Repository](https://github.com/opencost/opencost)
- [OpenCost Helm Charts](https://github.com/opencost/opencost-helm-chart)
