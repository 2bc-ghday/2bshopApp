#!/bin/bash
# Script to generate backend.conf from variables.tf

# Extract variable default values from variables.tf
RESOURCE_GROUP=$(grep -A3 'variable "resource_group_name"' variables.tf | grep default | cut -d '"' -f2)
STORAGE_ACCOUNT=$(grep -A3 'variable "storage_account_name"' variables.tf | grep default | cut -d '"' -f2)
CONTAINER=$(grep -A3 'variable "container_name"' variables.tf | grep default | cut -d '"' -f2)
KEY=$(grep -A3 'variable "key"' variables.tf | grep default | cut -d '"' -f2)

# Generate backend.conf
cat > backend.conf << EOF
resource_group_name  = "${RESOURCE_GROUP}"
storage_account_name = "${STORAGE_ACCOUNT}"
container_name       = "${CONTAINER}"
key                  = "${KEY}"
EOF

echo "Generated backend.conf with values from variables.tf"
