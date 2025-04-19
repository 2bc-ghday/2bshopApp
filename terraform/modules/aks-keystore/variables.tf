variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}
