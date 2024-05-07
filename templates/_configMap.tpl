{{- define "common-chart.configmap" -}}
{{- range $key, $value := .Values.configs }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common-chart.fullname" $ }}
  labels:
  {{- include "common-chart.fullname" $ | nindent 4 }}
data:
{{ toYaml $value | indent 2 }}
{{-end }}
{{-end }}