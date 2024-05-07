{{- define "common-chart.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common-chart.fullname" . }}
  labels:
  {{- include "common-chart.labels" . | nindent 4 }}
spec:
{{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.replicaCount }}
{{- end }}
  selector:
    matchLabels:
      {{- include "common-chart.selectorLabels" . |nindent 6 }}
  template:
    metadata:
      annotations:
        checksum/config: {{ include ("common-chart.configmap") . | sha256sum }}
      {{- include "common-chart.annotations" . |nindent 8 }}
      labels:
      {{- include "common-chart.labels" . |nindent 8 }}
    spec:
      {{- if $.Values.nodeSelector }}
      nodeSelector:
      {{ toYaml $.Values.nodeSelector | indent 8 }}
      {{- end }}
      {{- with .Values.imagePullSecrets }}
      imagePullSecrets:
        {{ toYaml . | nindent 8 }}
      {{- end }}
      securityContext:
        {{- toYaml .Values.podsecurityContext |nindent 8 }}
      containers:
        - name: {{ .Release.Name }}
          securityContext:
          {{- toYaml .Values.securityContext | nindent 12 }}
          {{- with .Values.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
          envFrom:
          {{- if .Values.configs }}
          - configMapRef:
              name: {{ include "common-chart.fullname" . }}
          {{- end }}
          {{- if or .Values.staticSecrets .Values.secrets }}
          - secretRef:
              name: {{ include "common-chart.fullname" . }}
          {{- end }}
          ports:
            - name: {{ .Values.service.name }}
              containerPort: {{ .Values.service.port }}
              protocol: {{ .Values.service.protocol }}
          {{- if .Values.livenessProbe }}
            {{- tpl (toYaml .Values.livenessProbe) $ | nindent 12}}
          {{- end }}
          {{- if .Values.readinessProbe }}
            {{- tpl (toYaml .Values.readinessProbe) $ | nindent 12}}
          {{- end }}
          resources:
            {{- toYaml .Values.resources | nindent 12 }}
      {{- with .Values.affinity }}
      affinity:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.tolerations }}
      tolerations:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.volumes }}
      volumes:
      {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end }}