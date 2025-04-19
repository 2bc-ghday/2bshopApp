variable "key_vault_id" {
  description = "ID of the Azure Key Vault"
  type        = string
}

variable "secrets" {
  description = "Map of secrets to create in Key Vault"
  type        = map(string)
  default     = {}
}

# Create Azure Key Vault secrets
resource "azurerm_key_vault_secret" "secrets" {
  for_each     = var.secrets
  name         = each.key
  value        = each.value
  key_vault_id = var.key_vault_id
}
