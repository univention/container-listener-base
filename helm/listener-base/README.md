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
| oci://artifacts.software-univention.de/nubus/charts | nubus-common | 0.28.0 |

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
			<td>image.pullSecrets</td>
			<td>list</td>
			<td><pre lang="json">
[]
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
			<td>image.sha256</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Define image sha256 as an alternative to `tag`</td>
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
			<td>listenerBase.caCert</td>
			<td>string</td>
			<td><pre lang="json">
"/var/secrets/ca_cert"
</pre>
</td>
			<td>CA root certificate, base64-encoded. Optional; will be written to "caCertFile" if set.</td>
		</tr>
		<tr>
			<td>listenerBase.caCertFile</td>
			<td>string</td>
			<td><pre lang="json">
""
</pre>
</td>
			<td>Where to search for the CA Certificate file. caCertFile: "/var/secrets/ca_cert"</td>
		</tr>
		<tr>
			<td>listenerBase.debugLevel</td>
			<td>string</td>
			<td><pre lang="json">
"4"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listenerBase.environment</td>
			<td>string</td>
			<td><pre lang="json">
"production"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listenerBase.ldapBaseDn</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listenerBase.ldapHost</td>
			<td>string</td>
			<td><pre lang="json">
"ucs-machine"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listenerBase.ldapHostDn</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listenerBase.ldapHostIp</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Will add a mapping from "ldapHost" to "ldapHostIp" into "/etc/hosts" if set</td>
		</tr>
		<tr>
			<td>listenerBase.ldapPassword</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>LDAP password for `cn=admin`. Will be written to "ldapPasswordFile" if set.</td>
		</tr>
		<tr>
			<td>listenerBase.ldapPasswordFile</td>
			<td>string</td>
			<td><pre lang="json">
"/var/secrets/ldap_secret"
</pre>
</td>
			<td>The path to the "ldapPasswordFile" docker secret or a plain file</td>
		</tr>
		<tr>
			<td>listenerBase.ldapPort</td>
			<td>string</td>
			<td><pre lang="json">
"389"
</pre>
</td>
			<td></td>
		</tr>
		<tr>
			<td>listenerBase.notifierServer</td>
			<td>string</td>
			<td><pre lang="json">
null
</pre>
</td>
			<td>Defaults to "ldapHost" if not set.</td>
		</tr>
		<tr>
			<td>listenerBase.tlsMode</td>
			<td>string</td>
			<td><pre lang="json">
"secure"
</pre>
</td>
			<td>Whether to start encryption and validate certificates. Chose from "off", "unvalidated" and "secure".</td>
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

