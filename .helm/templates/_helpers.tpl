{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "dev-env.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kube-namespace" -}}
{{- printf "%s-%s" .Values.git.tag .Values.git.name | lower | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ingressDomain" -}}
{{- printf "%s.%s.%s" .Values.git.tag .Values.git.name .Values.devDomain | lower | trunc 255 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dev-env.fullname" -}}
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
{{- define "dev-env.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "corrected.environment" -}}
{{- if eq .Values.global.env_name "prod" -}}
{{- printf "production" -}}
{{- end -}}
{{- if eq .Values.global.env_name "dev" -}}
{{- printf "development" -}}
{{- end -}}
{{- end -}}

{{- define "apps-env-var-values" -}}
{{- $globals := ternary .Values.global.prod .Values.global.dev (eq .Values.global.env_name "prod") -}}
- name: NODE_ENV
  value: "{{ include "corrected.environment" . }}"
- name: SITE_FB_PIXEL
  value: "{{ $globals.fbPixel }}"
- name: SITE_GTM
  value: "{{ $globals.gtm }}"
- name: SITE_URL
  value: "https://{{ .Values.global.ci_url }}{{- if and (ne .Values.global.ci_path "") (ne .Values.global.ci_path "/") }}/{{ .Values.global.ci_path | trimAll "/" }}{{- else }}/{{- end }}"
- name: NUXT_ENV_S3BACKET
  value: "{{ $globals.s3UrlBacket }}"
- name: NUXT_ENV_API_URL
  value: "{{ $globals.apiUrl }}"
{{- end -}}
