# Push Helm Chart to ACR

This custom GitHub Action packages a Helm chart and pushes it to Azure Container Registry (ACR).

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `chart-name` | Name of the Helm chart to push | Yes | - |
| `sha-tag` | Git SHA tag to use for the chart version | Yes | - |
| `app-version` | App version of the Helm chart to push | Yes | - |
| `acr-name` | Azure Container Registry name | Yes | - |

## Usage

```yaml
- name: Push Helm chart to ACR
  uses: ./.github/actions/push-helm
  with:
    chart-name: app2bshops
    sha-tag: ${{ github.sha }}
    app-version: 1.0.0
    acr-name: myregistry.azurecr.io
```

## What it does

1. Creates a directory for packaged charts
2. Packages the specified Helm chart with the provided version information
3. Pushes the packaged chart to the specified Azure Container Registry

## Prerequisites

- Helm must be installed and configured
- The workflow must be authenticated to the Azure Container Registry (using `azure/login` and appropriate credentials before calling this action)
