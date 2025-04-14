{{/*
Frontend labels
*/}}
{{- define "frontend.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/name: {{ .Release.Name }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: frontend
{{- end -}}

{{/*
Frontend selector labels
*/}}
{{- define "frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ .Release.Name }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: frontend
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "frontend.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
