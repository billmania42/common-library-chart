{{- define "common-chart.pvc" -}}
{{- range .Values.persistentStorage.claims }}
---
apiVersion: v1
kind: PersistentStorageClaim
metadata:
  name: {{ printf "%s-%s" (include "common-chart.fullname" $) .name }}
  labels:
  {{- include "common-chart.labels" $ |nindent 4 }}
  annotations:
spec:
  accessModes:
  {{- range .accessModes }}
  - {{ . }}
  {{- end }}
  resources:
    requests:
      storage: {{ .capacity }}
  storageClassName: {{ .storageClass }}
  volumeMode: {{ .volumeMode }}
{{- end }}
{{- end }}
