# 2B Shops Application

This project is a fork of the [Full Stack FastAPI Template](https://github.com/fastapi/full-stack-fastapi-template).  
It was modified by [2bcloud](https://2bcloud.io) as part of the GitHub April 2025 Workshop hosted on the Microsoft TLV Reactor.  
The goal of this project is to provide a **working** full-stack application exmple for deomonstrating the full capabilities of the GitHub Copilot and GitHub Advanced Security tools.  
The application is a simple e-commerce platform that allows users to create an account, manage their profile, and view items for sale.
examples for security vulnerability detection.

## Github Copilot Demo Videos

The following videos demonstrate the capabilities of GitHub Copilot in generating code for the 2B Shops application:

- [Github Copliot Workspace](./videos/1-workspace-example.mp4)
- [GitHub Copilot Agent - Backend](./videos/2-agent-backend.mp4)
- [GitHub Copilot Agent - Frontend](./videos/3-agent-frontend.mp4)
- [Github Copliot MCP Example](./videos/4-mcp-example.mp4)

## GitHub Advanced Security Examples

This repository includes examples of common security vulnerabilities that can be detected using GitHub Advanced Security:

- **SQL Injection**: Example of SQL injection vulnerability in `/advanced-security-samples/SQL_Injection_Vulnerability.py`
- **XSS (Cross-Site Scripting)**: Example of XSS vulnerability in `/advanced-security-samples/Cross-Site Scripting (XSS) Vulnerability.js`
- **Hardcoded Credentials**: Example of hardcoded credentials in `/advanced-security-samples/exposed_credentials.py`

These examples are for demonstration purposes only and showcase how GitHub Advanced Security can detect these vulnerabilities automatically.

**DO NOT** use these examples in production code!

## Technology Stack and Features

- ⚡ [**FastAPI**](https://fastapi.tiangolo.com) for the Python backend API.
  - 🧰 [SQLModel](https://sqlmodel.tiangolo.com) for the Python SQL database interactions (ORM).
  - 🔍 [Pydantic](https://docs.pydantic.dev), used by FastAPI, for the data validation and settings management.
- 🚀 [React](https://react.dev) for the frontend.
  - 💃 Using TypeScript, hooks, Vite, and other parts of a modern frontend stack.
  - 🎨 [Chakra UI](https://chakra-ui.com) for the frontend components.
- 💾 [PostgreSQL](https://www.postgresql.org) as the SQL database.
- 🏭 CI (continuous integration) and CD (continuous deployment) based on GitHub Actions.
- 🛡️ GitHub Advanced Security

## Configure

### When Using Docker Compose

You can then update configs in the `.env` files to customize your configurations.

### When Using Kubernetes

You can then update configs in the `values.yaml` files to customize your configurations.

## Kubernetes Deployment

This project includes Kubernetes deployment capabilities using Helm charts:

- `/charts/` directory contains all Helm charts for deploying the application on Kubernetes
- `/charts/app2bshops/` is the umbrella chart that deploys the entire application
- `/charts/backend/` and `/charts/frontend/` contain component-specific charts

### Local Kubernetes Deployment

To deploy the application to a local Kubernetes cluster (like minikube, kind, or Docker Desktop), you can use:

```bash
./scripts/deploy-k8s-local.sh
```

This script will:

1. Build and push Docker images to a local registry
2. Install the Helm chart with local development values
3. Set up port forwarding to access services locally

After deployment, you can access:

- Frontend at http://localhost:5173
- Backend at http://localhost:8000

#

## Deployment

<!-- Deployment docs: [deployment.md](./deployment.md). -->

TBD

## Credits

This project is a fork of [Full Stack FastAPI Template](https://github.com/fastapi/full-stack-fastapi-template) created by [Sebastián Ramírez (tiangolo)](https://github.com/tiangolo).

## License

The Full Stack FastAPI Template is licensed under the terms of the MIT license.
