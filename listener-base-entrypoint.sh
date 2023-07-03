#!/bin/bash
set -euxo pipefail

DOMAIN_NAME="${DOMAIN_NAME:-univention-organization.intranet}"
CA_CERT_FILE="${CA_CERT_FILE:-/dev/null}"
CERT_PEM_FILE="${CERT_PEM_FILE:-/dev/null}"
LDAP_HOST="${LDAP_HOST:-ldap.univention-organization.intranet}"
LDAP_PORT="${LDAP_PORT:-389}"
LDAP_BASE_DN="${LDAP_BASE_DN:-dc=univention-organization,dc=intranet}"
LDAP_HOST_DN="${LDAP_HOST_DN:-cn=ucs-4711,cn=dc,cn=computers,dc=univention-organization,dc=intranet}"
LDAP_BIND_DN="${LDAP_BIND_DN:-cn=admin,${LDAP_BASE_DN}}"
DEBUG_LEVEL="${DEBUG_LEVEL:-5}"
NOTIFIER_SERVER="${NOTIFIER_SERVER:-notifier.univention-organization.intranet}"
LDAP_BIND_SECRET="${LDAP_BIND_SECRET:-/dev/null}"
START_TLS="${START_TLS:-require}"
TLS_REQCERT=${TLS_REQCERT:-demand}

target_dir="/etc/univention/ssl/ucs-6045.${DOMAIN_NAME}"
mkdir --parents "${target_dir}" "/etc/univention/ssl/ucsCA/"
ln --symbolic --force "${CA_CERT_FILE}" "/etc/univention/ssl/ucsCA/CAcert.pem"
ln --symbolic --force "${CERT_PEM_FILE}" "${target_dir}/cert.pem"


# Add certificate of root ca
if [ ! -e /usr/local/share/ca-certificates/ucs-ca ]
then
    echo "Adding CA_CERT_FILE to system ca certificates bundle"
    mkdir --parents /usr/local/share/ca-certificates/ucs-ca
    cp "${CA_CERT_FILE}" /usr/local/share/ca-certificates/ucs-ca/ca_cert.crt
    update-ca-certificates
fi

state_dir="/var/lib/univention-directory-listener"

current_owner="$(stat -c "%U" "${state_dir}")"
if [ "${current_owner}" != "listener" ]
then
    echo "Trying to adjust owner of directory ${state_dir}"
    chown -R listener: "${state_dir}"
fi

cat <<EOF > /etc/ldap/ldap.conf
# This file should be world readable but not world writable.

TLS_CACERT /etc/univention/ssl/ucsCA/CAcert.pem
TLS_REQCERT ${TLS_REQCERT}

URI ldap://${LDAP_HOST}:${LDAP_PORT}

BASE	${LDAP_BASE_DN}
EOF

ucr set \
    server/role="memberserver" \
    ldap/master="${LDAP_HOST}" \
    ldap/master/port="${LDAP_PORT}" \
    ldap/hostdn="${LDAP_HOST_DN}" \
    ldap/base="${LDAP_BASE_DN}"

case ${START_TLS} in
  never)
    TLS_NO=0
    export TLS_PARAM=""
    ;;

  request)
    TLS_NO=1
    export TLS_PARAM="-Z"
    ;;

  *)  # require
    TLS_NO=2
    export TLS_PARAM="-ZZ"
    ;;
esac

find /usr/local/lib/python3.7/dist-packages
sed --in-place --expression="s/access[(]/access(start_tls=${TLS_NO}, /" /usr/local/lib/python3.7/dist-packages/univention/listener/handler.py

exec "$@"
