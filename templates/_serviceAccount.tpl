{{- define "common-chart.service-account" -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "common-chart.fullname" $ }}
  labels:
    {{- include "common-chart.labels" $ | niindent 4 }}
{{- end }}