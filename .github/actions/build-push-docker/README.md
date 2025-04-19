# Build and Push Docker Images

This custom GitHub Action builds Docker images using docker-compose and pushes them to Azure Container Registry (ACR).

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `app-name` | Name of the application to build | Yes | - |
| `app-tag` | The tag to use for the Docker image | Yes | - |
| `acr-server` | ACR server URL | Yes | - |
| `stack-name` | Stack name for docker compose project | Yes | `2bshops` |

## Usage

```yaml
- name: Build and push app image
  uses: ./.github/actions/build-push-docker
  with:
    app-name: backend
    app-tag: ${{ github.sha }}
    acr-server: myregistry.azurecr.io
    stack-name: 2bshops
```

## What it does

1. Builds the specified application using Docker Compose
2. Tags the image with both the specified tag and 'latest'
3. Pushes all tags to the specified Azure Container Registry

## Prerequisites

- Docker must be installed and configured
- Docker Compose must be available
- The workflow must be authenticated to the Azure Container Registry (using `azure/login` and `docker/login-action` before calling this action)
