{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "woodpecker-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "woodpecker-agent.fullname" -}}
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
{{- define "woodpecker-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the correct image tag name
*/}}
{{- define "woodpecker-agent.imageTag" -}}
{{- .Values.image.tag | default .Chart.AppVersion -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "woodpecker-agent.labels" -}}
helm.sh/chart: {{ include "woodpecker-agent.chart" . }}
{{ include "woodpecker-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ include "woodpecker-agent.imageTag" . }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "woodpecker-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "woodpecker-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: woodpecker-agent
{{- end -}}
