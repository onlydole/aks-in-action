variable "project_name" {
  type        = string
  description = "Globally used project name"
  default     = "aks-in-action"
}

variable "region" {
  type        = string
  description = "Azure Region that will be used"
  default     = "West US"
}

variable "cluster_version" {
  type        = string
  description = "The AKS Kubernetes minor version for our clusters. AKS runs the latest GA patch of this minor."
  default     = "1.36"
}

variable "cidr" {
  type        = string
  description = "The CIDR block to use for this demo"
  default     = "11.0.0.0/16"
}
