{{- define "listener-base.labels" -}}
{{- $standardLabels := include "common.labels.standard" . | fromYaml -}}
{{- $templatedLabels := dict -}}
{{- range $key, $value := .Values.additionalLabels -}}
{{- $_ := set $templatedLabels $key (tpl ($value | toString) $) -}}
{{- end -}}
{{- $allLabels := merge $templatedLabels $standardLabels -}}
{{- toYaml $allLabels -}}
{{- end -}}
