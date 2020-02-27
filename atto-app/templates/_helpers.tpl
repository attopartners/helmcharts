{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "atto-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "atto-app.vaultDb" -}}
{{- default .Release.Name .Values.vaultDb | trimSuffix "-" -}}
{{- end -}}
{{- define "atto-app.vaultAws" -}}
{{- default .Release.Name .Values.vaultAws | trimSuffix "-" -}}
{{- end -}}
{{- define "atto-app.vaultConfig" -}}
{{- default .Release.Name .Values.vaultConfig | trimSuffix "-" -}}
{{- end -}}
{{- define "atto-app.vaultRole" -}}
{{- default .Release.Name .Values.vaultRole | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "atto-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "atto-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "atto-app.labels" -}}
helm.sh/chart: {{ include "atto-app.chart" . }}
{{ include "atto-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Sidekiq labels
*/}}
{{- define "atto-app.sidekiqLabels" -}}
helm.sh/chart: {{ include "atto-app.chart" . }}
{{ include "atto-app.sidekiqSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Migration labels
*/}}
{{- define "atto-app.migrationLabels" -}}
helm.sh/chart: {{ include "atto-app.chart" . }}
{{ include "atto-app.migrationSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "atto-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "atto-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Sidekiq Selector labels
*/}}
{{- define "atto-app.sidekiqSelectorLabels" -}}
app.kubernetes.io/name: {{ include "atto-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-sidekiq
{{- end -}}
{{/*
Migration Selector labels
*/}}
{{- define "atto-app.migrationSelectorLabels" -}}
app.kubernetes.io/name: {{ include "atto-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}-migration
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "atto-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "atto-app.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
