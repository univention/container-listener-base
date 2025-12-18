# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2025 Univention GmbH

{{- define "listener-base.labels" -}}
{{- $standardLabels := include "common.labels.standard" . | fromYaml -}}
{{- $templatedLabels := dict -}}
{{- range $key, $value := .Values.additionalLabels -}}
{{- $_ := set $templatedLabels $key (tpl ($value | toString) $) -}}
{{- end -}}
{{- $allLabels := merge $templatedLabels $standardLabels -}}
{{- toYaml $allLabels -}}
{{- end -}}
