# listener-base

The base listener with a debugging handler installed

- **Version**: 0.1.0
- **Type**: application
- **AppVersion**: 0.0.1
-

## Introduction

This chart does install a the base listener container with a debugging handler.

It is mainly intended to help with testing if an environment is hooked up
correctly. The handler will log all events, so that it is easy to observe if the
events arrive.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | ^2.2.2 |

## Values

<table>
	<thead>
		<th>Key</th>
		<th>Type</th>
		<th>Default</th>
		<th>Description</th>
	</thead>
	<tbody>
		<tr>
			<td>affinity</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>autoscaling.enabled</td>
			<td>bool</td>
			<td><pre lang="json">
false
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>autoscaling.maxReplicas</td>
			<td>int</td>
			<td><pre lang="json">
100
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>autoscaling.minReplicas</td>
			<td>int</td>
			<td><pre lang="json">
1
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>autoscaling.targetCPUUtilizationPercentage</td>
			<td>int</td>
			<td><pre lang="json">
80
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>fullnameOverride</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.pullPolicy</td>
			<td>string</td>
			<td><pre lang="json">
"Always"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.registry</td>
			<td>string</td>
			<td><pre lang="json">
"gitregistry.knut.univention.de"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.repository</td>
			<td>string</td>
			<td><pre lang="json">
"univention/customers/dataport/upx/container-listener-base/listener-base-debug"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>image.tag</td>
			<td>string</td>
			<td><pre lang="json">
"latest"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>imagePullSecrets</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.auth_ldap_secret</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td>LDAP access password, base64 encoded. See /etc/ldap.secret on your UCS machine.</td>
		</tr>
		<tr>
			<td>listener_base.ca_cert</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td>CA certificate of UCS machine, base64 encoded.</td>
		</tr>
		<tr>
			<td>listener_base.ca_cert_file</td>
			<td>string</td>
			<td><pre lang="json">
"/var/secrets/ca_cert"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.cert_pem</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td>Certificate of the ucs machine, base64 encoded.</td>
		</tr>
		<tr>
			<td>listener_base.cert_pem_file</td>
			<td>string</td>
			<td><pre lang="json">
"/var/secrets/cert_pem"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.debug_level</td>
			<td>string</td>
			<td><pre lang="json">
"5"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.environment</td>
			<td>string</td>
			<td><pre lang="json">
"staging"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.ldap_base_dn</td>
			<td>string</td>
			<td><pre lang="json">
"dc=univention,dc=intranet"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.ldap_bind_secret</td>
			<td>string</td>
			<td><pre lang="json">
"/var/secrets/ldap_secret"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.ldap_host</td>
			<td>string</td>
			<td><pre lang="json">
"ucs-machine"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.ldap_host_ip</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td>Will add a mapping from "ldap_host" to "ldap_host_ip" into "/etc/hosts" if set</td>
		</tr>
		<tr>
			<td>listener_base.ldap_port</td>
			<td>string</td>
			<td><pre lang="json">
"389"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listener_base.notifier_server</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td>Defaults to "ldap_host" if not set.</td>
		</tr>
		<tr>
			<td>nameOverride</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>nodeSelector</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>podAnnotations</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>podSecurityContext</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>replicaCount</td>
			<td>int</td>
			<td><pre lang="json">
1
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>resources</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>securityContext</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>serviceAccount.annotations</td>
			<td>object</td>
			<td><pre lang="json">
{}
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>serviceAccount.create</td>
			<td>bool</td>
			<td><pre lang="json">
true
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>serviceAccount.name</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>tolerations</td>
			<td>list</td>
			<td><pre lang="json">
[]
</pre>
</td>
			<td></td>
		</tr>
	</tbody>
</table>

