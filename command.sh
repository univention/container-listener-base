#!/bin/bash
set -euxo pipefail

case "${TLS_REQCERT:-demand}" in
  "never")
    TLS_FLAGS="-zz"
    ;;
  "allow" | "try")
    TLS_FLAGS="-z"
    ;;
  *)
    TLS_FLAGS="-ZZ"
    ;;
esac

exec "/usr/sbin/univention-directory-listener" \
  -F -x -d "${DEBUG_LEVEL}" \
  -b "${LDAP_BASE_DN}" \
  -D "cn=admin,${LDAP_BASE_DN}" \
  -n "${NOTIFIER_SERVER}" \
  -m /usr/lib/univention-directory-listener/system \
  -c /var/lib/univention-directory-listener \
  -y "${LDAP_BIND_SECRET}" \
  "${TLS_FLAGS}"

# [EOF]
