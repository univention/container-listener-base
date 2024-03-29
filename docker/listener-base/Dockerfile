# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2023 Univention GmbH

ARG UCS_BASE_IMAGE_TAG=0.11.0
ARG UCS_BASE_IMAGE=gitregistry.knut.univention.de/univention/components/ucs-base-image/ucs-base-506

FROM ${UCS_BASE_IMAGE}:${UCS_BASE_IMAGE_TAG} AS ucs-sources-base

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

FROM ucs-sources-base as deb_builder

COPY patches/allow_disabling_tls.patch \
     patches/separate_notifier_address.patch \
     /root/

WORKDIR /root/src/debian/

# hadolint ignore=DL3003
RUN \
  apt-get update && \
  apt-get build-dep --assume-yes univention-directory-listener && \
  apt-get source univention-directory-listener && \
  cd univention-directory-listener-* && \
  patch -p3 < /root/separate_notifier_address.patch && \
  patch -p3 < /root/allow_disabling_tls.patch && \
  dpkg-buildpackage -uc -us -b && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*


FROM ucs-sources-base as final

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN \
  echo "postfix postfix/main_mailer_type string 'Satellite system'" \
    | debconf-set-selections && \
  echo "postfix postfix/mailname string univention-directory-listener" \
    | debconf-set-selections && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    postfix && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY --from=deb_builder \
    /root/src/debian/univention-directory-listener_*.deb /root/

COPY patches/make_uldap_start-tls_configurable.patch /root/

# hadolint ignore=DL3008
RUN \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    /root/univention-directory-listener_*.deb \
    patch \
    python3-distutils \
    python3-univention-directory-manager && \
  patch -p 0 -d / -i /root/make_uldap_start-tls_configurable.patch && \
  apt-get purge --auto-remove --assume-yes patch && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
  awk \
    '/^Package: univention-directory-listener$/{ while(!/^Version: /){getline} print $2 }' \
    /var/lib/dpkg/status > /version

RUN \
  rm /usr/lib/univention-directory-listener/system/*

COPY ./command.sh /
COPY ./listener-base-entrypoint.envsh /entrypoint.d/50-listener-base-entrypoint.envsh

CMD ["/command.sh"]


FROM final as debug

COPY ./listener_handler.py /usr/lib/univention-directory-listener/system/
