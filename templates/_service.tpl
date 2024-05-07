{{- define "common-chart.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "common-chart.fullname" . }}
  labels:
  {{- include "common-chart.labels" . | nindent 4 }}
spec:
  tpye: {{ .Values.service.type }}
  ports:
  {{- range .Values.service.ports }}
    - port: {{ .port }}
      targetPort: {{ .templatePort}}
      protocol: {{ .protocol | upper }}
      name: {{ printf "%s-%s" "tcp" .port }}
  {{- end }}
  selector:
  {{- include "common-chart.selectorLabels" . | nindent 4 }}
{{- end }}