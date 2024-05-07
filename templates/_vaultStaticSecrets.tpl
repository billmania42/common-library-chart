{{- define "common-chart.vault-static-secret" -}}
{{- range .Values.staticSecrets }}
---
apiVersion: secrets.hashicorp.com/v1beta1
kind: VaultStaticSecret
metadata:
  name: {{ include "common-chart.fullname" $ }}-vss
  labels:
    {{- include "common-chart.labels" $ | nindent 4 }}
  annotations:
spec:
  type: {{ .vaultSecretType }}
  mount: {{ .vaultSecretMount }}
  path: {{ .vaultSecretPath }}
  hmacSecretData: true
  vaultAuthRef: {{ .vaultAuthRef }}
  rolloutRestartTargets:
    - kind: {{ .ocpTemplateType }}
      name: {{ include "common-chart.fullname" $ }}
  destiantion:
    name: {{ include "common-chart.fullname" $ }}-static
    create: {{ .ocpSecretCreate }}
    labels:
      {{- include "common-chart.labels" $ | nindent 4 }}
    type: {{ .ocpSecretType }}
  refreshAfter: {{ .vaultRefreshTime }}
{{- end }}
{{- end }}
