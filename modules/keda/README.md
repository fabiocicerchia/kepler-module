# KEDA Module

Terraform module to deploy KEDA (Kubernetes Event Driven Autoscaling) on your Kubernetes cluster using Helm.

## Features

- **Event-Driven Autoscaling**: Scale Kubernetes workloads based on external events
- **Multiple Scalers**: Support for various event sources (HTTP, Kafka, AWS, GCP, Azure, etc.)
- **Example Deployments**: Optional deployment of KEDA example manifests for testing

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
module "keda" {
  source = "./modules/keda"

  kubeconfig_path = "~/.kube/config"
}
```

### Without Example Manifests

```hcl
module "keda" {
  source = "./modules/keda"

  deploy_keda_example = false
}
```

### With Custom Namespace and Manifest Path

```hcl
module "keda" {
  source = "./modules/keda"

  keda_namespace     = "custom-keda"
  keda_manifest_path = "${path.module}/custom-keda-manifest.yaml"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deploy_keda_example | Deploy KEDA example manifests | `bool` | `true` | no |
| keda_manifest_path | Path to KEDA manifest file | `string` | `"keda.yaml"` | no |
| keda_namespace | Kubernetes namespace for KEDA | `string` | `"keda"` | no |
| keda_release_name | Helm release name for KEDA | `string` | `"kedacore"` | no |
| kubeconfig_path | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |

## Outputs

| Name | Description |
|------|-------------|
| keda_chart_version | Chart version of KEDA deployment |
| keda_namespace | Kubernetes namespace where KEDA is deployed |
| keda_release_name | Helm release name of KEDA |

## Notes

- KEDA example manifest file should be present in your working directory unless overridden
- The Helm provider requires access to your Kubernetes cluster via kubeconfig
- kubectl must be available in your PATH if deploying example manifests

## Related Resources

- [KEDA Documentation](https://keda.sh/)
- [KEDA GitHub Repository](https://github.com/kedacore/keda)
- [KEDA Helm Charts](https://github.com/kedacore/charts)
