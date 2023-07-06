#!/bin/bash
set -euxo pipefail

# Link certificates in place
CA_CERT_FILE=${CA_CERT_FILE:-/run/secrets/ca_cert}

if [[ -f "${CA_CERT_FILE}" ]]; then
  echo "Using provided CA certificate at ${CA_CERT_FILE}"
  CA_DIR="/etc/univention/ssl/ucsCA"

  mkdir --parents "${CA_DIR}"
  ln --symbolic --force "${CA_CERT_FILE}" "${CA_DIR}/CAcert.pem"
else
  unset CA_DIR
  echo "No CA certificate provided!"
fi

# Add certificate of root ca
if [[ -f "${CA_CERT_FILE}" ]] && [[ ! -e /usr/local/share/ca-certificates/ucs-ca ]]
then
    echo "Adding CA_CERT_FILE to system ca certificates bundle"
    mkdir --parents /usr/local/share/ca-certificates/ucs-ca
    cp "${CA_CERT_FILE}" /usr/local/share/ca-certificates/ucs-ca/ca_cert.crt
    update-ca-certificates
fi

# Adjust listener's folders' ownership
state_dir="/var/lib/univention-directory-listener"

current_owner="$(stat -c "%U" "${state_dir}")"
if [ "${current_owner}" != "listener" ]
then
    echo "Trying to adjust owner of directory ${state_dir}"
    chown -R listener: "${state_dir}"
fi

# Configure LDAP client
cat <<EOF > /etc/ldap/ldap.conf
# This file should be world readable but not world writable.

${CA_DIR:+TLS_CACERT /etc/univention/ssl/ucsCA/CAcert.pem}
TLS_REQCERT ${TLS_REQCERT:-demand}

URI ldap://${LDAP_HOST}:${LDAP_PORT}

BASE ${LDAP_BASE_DN}
EOF
chmod 0644 /etc/ldap/ldap.conf

case "${TLS_REQCERT:-demand}" in
  "never")
    ucr set uldap/start-tls=0
    ;;
  "allow" | "try")
    ucr set uldap/start-tls=1
    ;;
  *)
    ucr set uldap/start-tls=2
    ;;
esac

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
