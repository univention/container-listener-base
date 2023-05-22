#!/bin/bash
set -euxo pipefail

target_dir="/etc/univention/ssl/ucs-6045.${DOMAIN_NAME}"
mkdir --parents "${target_dir}" "/etc/univention/ssl/ucsCA/"
ln --symbolic --force "${CA_CERT_FILE}" "/etc/univention/ssl/ucsCA/CAcert.pem"
ln --symbolic --force "${CERT_PEM_FILE}" "${target_dir}/cert.pem"

cat <<EOF > /etc/ldap/ldap.conf
# This file should be world readable but not world writable.

TLS_CACERT /etc/univention/ssl/ucsCA/CAcert.pem
TLS_REQCERT ${TLS_REQCERT:-demand}

URI ldap://${LDAP_HOST}:${LDAP_PORT}

BASE	${LDAP_BASE_DN}
EOF

ucr set server/role='memberserver'
ucr set ldap/master="${LDAP_HOST}"
ucr set ldap/master/port="${LDAP_PORT}" # 636, 389
ucr set ldap/hostdn="${LDAP_HOST_DN}"
ucr set ldap/base="${LDAP_BASE_DN}"

exec "/usr/sbin/univention-directory-listener" \
  -F -x -d "${DEBUG_LEVEL}" \
  -b "${LDAP_BASE_DN}" \
  -D "cn=admin,${LDAP_BASE_DN}" \
  -n "${NOTIFIER_SERVER}" \
  -m /usr/lib/univention-directory-listener/system \
  -c /var/lib/univention-directory-listener \
  -y "${LDAP_BIND_SECRET}" -ZZ

# [EOF]
