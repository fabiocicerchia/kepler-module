variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "~/.kube/config"
}

variable "release_name" {
  description = "Helm release name for KubeGreen"
  type        = string
  default     = "kube-green"
}

variable "namespace" {
  description = "Kubernetes namespace for KubeGreen"
  type        = string
  default     = "kube-green"
}

variable "values" {
  description = "KubeGreen Helm chart values"
  type        = any
  default     = {}
}
variable "chart_version" {
  description = "KubeGreen Helm chart version (empty string for latest)"
  type        = string
  default     = ""
}