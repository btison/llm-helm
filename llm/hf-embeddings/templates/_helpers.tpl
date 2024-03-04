{{/*
Expand the name of the chart.
*/}}
{{- define "hf-embeddings.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hf-embeddings.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hf-embeddings.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hf-embeddings.labels" -}}
helm.sh/chart: {{ include "hf-embeddings.chart" . }}
{{ include "hf-embeddings.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hf-embeddings.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hf-embeddings.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hf-embeddings.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "hf-embeddings.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "pvc.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.pvc.argocd.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.pvc.argocd.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}