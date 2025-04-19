# GitHub Configuration

This directory contains GitHub-specific configuration files for automating workflows, dependency management, and custom actions.

## Directory Structure

- **workflows/**: Contains GitHub Actions workflow definitions
- **actions/**: Contains custom GitHub Actions used by the workflows
- **dependabot.yml**: Configuration for automated dependency updates via GitHub Dependabot

## Workflows

The following workflows are configured in this repository:

- **test-backend.yml**: Runs tests for the backend application
- **lint-backend.yml**: Runs linting for the backend code
- **generate-client.yml**: Generates API client code
- **test-docker-compose.yml**: Tests the Docker Compose setup
- **push-to-acr.yml**: Pushes Docker images to Azure Container Registry
- **deploy-to-aks.yml**: Deploys the application to Azure Kubernetes Service
- **cleanup-acr.yml**: Cleans up old images from Azure Container Registry

For detailed information about each workflow, see the [workflows README](./workflows/README.md).

## Custom Actions

Custom GitHub Actions are maintained in the `actions/` directory:

- **build-push-docker**: Action to build and push Docker images to ACR
- **push-helm**: Action to push Helm charts to ACR

For detailed information about each custom action, see their respective README files.

## Dependency Management

Dependabot is configured to automatically create pull requests for outdated dependencies.
See `dependabot.yml` for specific configuration details.
