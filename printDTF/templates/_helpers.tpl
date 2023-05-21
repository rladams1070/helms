{{/*
Expand the name of the chart.
*/}}
{{- define "printDTF.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "printDTF.backend.name" -}}
{{- default .Chart.Name .Values.backend.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- define "printDTF.frontend.name" -}}
{{- default .Chart.Name .Values.frontend.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "printDTF.fullname" -}}
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
{{- define "printDTF.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "printDTF.labels" -}}
helm.sh/chart: {{ include "printDTF.chart" . }}
{{ include "printDTF.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- define "printDTF.backend.labels" -}}
helm.sh/chart: {{ include "printDTF.chart" . }}
{{ include "printDTF.backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{- define "printDTF.frontend.labels" -}}
helm.sh/chart: {{ include "printDTF.chart" . }}
{{ include "printDTF.frontend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "printDTF.selectorLabels" -}}
app.kubernetes.io/name: {{ include "printDTF.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "printDTF.backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "printDTF.backend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{- define "printDTF.frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "printDTF.frontend.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "printDTF.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "printDTF.name" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
