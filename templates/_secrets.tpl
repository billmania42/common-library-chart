{{- define "common-chart.secrets" -}}
{{- range  $key, $value := .Values.secrets }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{- include "common-chart.fullname" $ }}
  labels:
  {{- include "common-chart.labels" $ | nindent 4 }}
type: Opaque
data:
{{ toYaml $value | indent 2 }}
{{- end }}
{{- end }}