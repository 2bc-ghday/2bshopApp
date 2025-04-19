# GitHub Workflows

This directory contains GitHub Actions workflows that automate various tasks for the 2B Shop App project.

## Available Workflows

### `test-backend.yml`
Automatically runs the backend test suite to ensure code quality and functionality.
- **Triggers**: Pull requests to main branch, manual workflow dispatch
- **Actions**: Sets up Python, installs dependencies, and runs backend tests

### `lint-backend.yml`
Checks backend code style and quality.
- **Triggers**: Pull requests to main branch, manual workflow dispatch
- **Actions**: Sets up Python, installs dependencies, and runs linting tools

### `generate-client.yml`
Generates TypeScript client code from the OpenAPI schema.
- **Triggers**: Changes to backend API definitions, manual workflow dispatch
- **Actions**: Generates client code and creates a PR with the updates

### `test-docker-compose.yml`
Ensures the Docker Compose setup works correctly.
- **Triggers**: Pull requests affecting Docker configuration, manual workflow dispatch
- **Actions**: Builds and tests the complete application using Docker Compose

### `push-to-acr.yml`
Builds and pushes Docker images to Azure Container Registry.
- **Triggers**: Pushes to main branch, manual workflow dispatch
- **Actions**: Builds Docker images, authenticates to ACR, and pushes images

### `deploy-to-aks.yml`
Deploys the application to Azure Kubernetes Service.
- **Triggers**: After successful image push to ACR, manual workflow dispatch
- **Actions**: Authenticates with Azure, updates Helm charts, and deploys to AKS

### `cleanup-acr.yml`
Removes old and unused images from Azure Container Registry.
- **Triggers**: Scheduled run (e.g., weekly), manual workflow dispatch
- **Actions**: Identifies and removes old container images to save storage space

## Usage

### Running Workflows Manually

Most workflows can be run manually from the GitHub Actions tab in the repository:

1. Go to the "Actions" tab in the GitHub repository
2. Select the workflow you want to run
3. Click the "Run workflow" button
4. Select the branch and provide any required inputs
5. Click "Run workflow" to start the execution

### Workflow Dependencies

Some workflows depend on others:
- `deploy-to-aks.yml` typically runs after `push-to-acr.yml` completes successfully
- `generate-client.yml` should be run after significant API changes

## Customization

To modify these workflows, edit the corresponding YAML files in this directory. Each workflow file contains detailed comments explaining the steps and configuration options.
