{{- define "common-chart.vault-static-secret" -}}
{{- range .Values.staticSecrets }}
---
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultStaticSecret
metadata:
  name:
  labels:
  annotations:
spec:
