#!/bin/bash
set -euxo pipefail

target_dir="/etc/univention/ssl/ucs-6045.${DOMAIN_NAME}"
mkdir --parents "${target_dir}" "/etc/univention/ssl/ucsCA/"
ln --symbolic --force "${CA_CERT_FILE}" "/etc/univention/ssl/ucsCA/CAcert.pem"
ln --symbolic --force "${CERT_PEM_FILE}" "${target_dir}/cert.pem"


# Add certificate of root ca
mkdir /usr/local/share/ca-certificates/ucs-ca
cp "${CA_CERT_FILE}" /usr/local/share/ca-certificates/ucs-ca/ca_cert.crt
update-ca-certificates


cat <<EOF > /etc/ldap/ldap.conf
# This file should be world readable but not world writable.

TLS_CACERT /etc/univention/ssl/ucsCA/CAcert.pem
TLS_REQCERT ${TLS_REQCERT:-demand}

URI ldap://${LDAP_HOST}:${LDAP_PORT}

BASE	${LDAP_BASE_DN}
EOF

ucr set \
    server/role="memberserver" \
    ldap/master="${LDAP_HOST}" \
    ldap/master/port="${LDAP_PORT}" \
    ldap/hostdn="${LDAP_HOST_DN}" \
    ldap/base="${LDAP_BASE_DN}"


exec "$@"
