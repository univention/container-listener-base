#!/bin/bash
set -euxo pipefail

exec "/usr/sbin/univention-directory-listener" \
  -F -x -d "${DEBUG_LEVEL}" \
  -b "${LDAP_BASE_DN}" \
  -D "cn=admin,${LDAP_BASE_DN}" \
  -n "${NOTIFIER_SERVER}" \
  -m "/usr/lib/univention-directory-listener/system" \
  -c "/var/lib/univention-directory-listener" \
  -y "${LDAP_BIND_SECRET}" \
  "${TLS_PARAM}"

# [EOF]
