data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  resource_group_name = var.resource_group_name
}

resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.namespace
  }
}

resource "helm_release" "csi_secrets_store" {
  name       = "csi-secrets-store"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  namespace  = var.namespace
  
  set {
    name  = "syncSecret.enabled"
    value = "true"
  }

  depends_on = [kubernetes_namespace.app_namespace]
}

resource "kubernetes_manifest" "azure_provider_installation" {
  manifest = yamldecode(file("${path.module}/templates/azure-provider-installer.yaml"))

  depends_on = [helm_release.csi_secrets_store]
}

# Create template files directory if it doesn't exist
resource "local_file" "azure_provider_template" {
  filename = "${path.module}/templates/azure-provider-installer.yaml"
  content  = <<-EOT
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: csi-secrets-store-provider-azure
  namespace: ${var.namespace}
  labels:
    app: csi-secrets-store-provider-azure
spec:
  selector:
    matchLabels:
      app: csi-secrets-store-provider-azure
  template:
    metadata:
      labels:
        app: csi-secrets-store-provider-azure
    spec:
      serviceAccountName: secrets-store-csi-driver
      containers:
        - name: provider-azure-installer
          image: mcr.microsoft.com/oss/azure/secrets-store/provider-azure:1.4.1
          imagePullPolicy: IfNotPresent
          args:
            - --provider-volume=/etc/kubernetes/secrets-store-csi-providers
          volumeMounts:
            - name: provider-volume
              mountPath: /etc/kubernetes/secrets-store-csi-providers
          resources:
            requests:
              cpu: 50m
              memory: 100Mi
            limits:
              cpu: 100m
              memory: 200Mi
      volumes:
        - name: provider-volume
          hostPath:
            path: /etc/kubernetes/secrets-store-csi-providers
  EOT

  depends_on = [kubernetes_namespace.app_namespace]
}

resource "kubernetes_manifest" "secret_provider_class" {
  manifest = {
    apiVersion = "secrets-store.csi.x-k8s.io/v1"
    kind       = "SecretProviderClass"
    metadata = {
      name      = "app2bshops-secrets"
      namespace = var.namespace
    }
    spec = {
      provider = "azure"
      parameters = {
        usePodIdentity        = "false"
        useVMManagedIdentity  = "true"
        userAssignedIdentityID = ""
        keyvaultName          = var.key_vault_name
        cloudName             = ""
        objects = jsonencode({
          array = [
            {
              objectName    = "SECRET-KEY"
              objectType    = "secret"
              objectVersion = ""
            },
            {
              objectName    = "POSTGRES-PASSWORD"
              objectType    = "secret"
              objectVersion = ""
            },
            {
              objectName    = "FIRST-SUPERUSER"
              objectType    = "secret" 
              objectVersion = ""
            },
            {
              objectName    = "FIRST-SUPERUSER-PASSWORD"
              objectType    = "secret"
              objectVersion = ""
            },
            {
              objectName    = "SMTP-HOST"
              objectType    = "secret"
              objectVersion = ""
            },
            {
              objectName    = "SMTP-USER" 
              objectType    = "secret"
              objectVersion = ""
            },
            {
              objectName    = "SMTP-PASSWORD"
              objectType    = "secret"
              objectVersion = ""
            },
            {
              objectName    = "SENTRY-DSN"
              objectType    = "secret"
              objectVersion = ""
            }
          ]
        })
        tenantId = var.tenant_id
      }
      secretObjects = [
        {
          data = [
            {
              key        = "SECRET_KEY"
              objectName = "SECRET-KEY"
            },
            {
              key        = "FIRST_SUPERUSER"
              objectName = "FIRST-SUPERUSER"
            },
            {
              key        = "FIRST_SUPERUSER_PASSWORD"
              objectName = "FIRST-SUPERUSER-PASSWORD"
            },
            {
              key        = "SMTP_HOST"
              objectName = "SMTP-HOST"
            },
            {
              key        = "SMTP_USER"
              objectName = "SMTP-USER"
            },
            {
              key        = "SMTP_PASSWORD"
              objectName = "SMTP-PASSWORD" 
            },
            {
              key        = "SENTRY_DSN"
              objectName = "SENTRY-DSN"
            }
          ]
          secretName = "app2bshops-backend-secrets"
          type       = "Opaque"
        },
        {
          data = [
            {
              key        = "POSTGRES_PASSWORD"
              objectName = "POSTGRES-PASSWORD"
            },
            {
              key        = "POSTGRES_USER"
              objectName = "postgres"
            }
          ]
          secretName = "app2bshops-backend-db-secrets"
          type       = "Opaque"
        }
      ]
    }
  }

  depends_on = [kubernetes_manifest.azure_provider]
}
