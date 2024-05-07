{{- define "common-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimsuffix "-" }}
{{- end }}

{{- define "common-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{ .Values.fullnameOverride | trunc 63 }}
{{- else }}
{{ $name := default .Release.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "common-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" |trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "common-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common-chart.fullname" . }}
app.kubernetes.io/instance: {{ include "common-chart.fullname" . }}
{{- end }}

{{- define "common-chart.labels" -}}
{{- $appVersionString := print ( .Values.appVersion | replace "." "-" ) }}
{{- $istioAppInstance := printf "%s-%s" .Release.Name $appVersionString -}}
app: {{ include "common-chart.fullname" . }}
version: {{ .Values.appVersion | quote }}
app.kubernetes.io/name: {{ include "common-chart.fullname" . }}
app.kubernetes.io/instance: {{ include "common-chart.fullname" . }}
app.kubernetes.io/owned-by: {{ "foo" }}
app.kubernetes.io/part-of: {{ .Values.partOf }}
app.kubernetes.io/managed-by: {{ .Values.managedBy }}
app.kubernetes.io/created-by: {{ .Values.createdBy }}
app.kubernetes.io/release: {{ .Values.release }}
app.kubernetes.io/stage: {{ .Values.stage }}
{{- end }}

{{- define "common-chart.annotations" -}}
sidecar.istio.io/inject: {{ .Values.istio.inject }}
sidecar.istio.io/proxyCPU: {{ .Values.istio.cpu }}
sidecar.istio.io/proxyCPULimit: {{ .Values.istio.cpuLimit }}
sidecar.istio.io/proxyMemory: {{ .Values.istio.memory }}
sidecar.istio.io/proxyMemoryLimit: {{ .Values.istio.memoryLimit }}
{{- end }}