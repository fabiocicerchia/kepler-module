variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "release_name" {
  description = "Helm release name for KEDA"
  type        = string
  default     = "kedacore"
}

variable "namespace" {
  description = "Kubernetes namespace for KEDA"
  type        = string
  default     = "keda"
}

variable "values" {
  description = "Helm values for KEDA deployment"
  type        = any
  default     = {}
}

variable "deploy_example" {
  description = "Deploy KEDA example manifests"
  type        = bool
  default     = true
}

variable "manifest_path" {
  description = "Path to KEDA manifest file"
  type        = string
  default     = "keda.yaml"
}
