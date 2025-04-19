variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "2bshops"
}

variable "location" {
  description = "Azure region"
  default     = "israelcentral"
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  default     = "2bshops"
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  default     = "2bshops-kv"
}

variable "namespace" {
  description = "Kubernetes namespace for the application"
  default     = "2bshops"
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account for Terraform state"
  type        = string
  default     = "2bshopsstate"
}

variable "container_name" {
  description = "Name of the container in the storage account for Terraform state"
  type        = string
  default     = "tfstate"
}

variable "key" {
  description = "Name of the key file for Terraform state"
  type        = string
  default     = "aks-infra.tfstate"
}

variable "secrets" {
  description = "Map of secrets to create in Key Vault"
  type        = map(string)
  default     = {}
  sensitive   = true
}
