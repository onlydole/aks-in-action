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
  description = "The Kubernetes version for our clusters"
  default     = "1.22.4"
}

variable "cidr" {
  type        = string
  description = "The CIDR block to use for this demo"
  default     = "11.0.0.0/16"
}
