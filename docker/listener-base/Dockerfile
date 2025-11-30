# SPDX-License-Identifier: AGPL-3.0-only
# SPDX-FileCopyrightText: 2023-2025 Univention GmbH

ARG UCS_BASE_IMAGE_TAG=5.2.3-build.20251128@sha256:2febf0d2be06f0cca264085db0270c2c61170ea93d14c7ff840c61ecd5328c70
ARG UCS_BASE_IMAGE=gitregistry.knut.univention.de/univention/dev/projects/ucs-base-image/ucs-base

FROM ${UCS_BASE_IMAGE}:${UCS_BASE_IMAGE_TAG} AS ucs-sources-base

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

FROM ucs-sources-base AS deb_builder

COPY patches/*.patch /root/

WORKDIR /root/src/debian/

# hadolint ignore=DL3003
RUN \
  apt-get build-dep --assume-yes univention-directory-listener && \
  apt-get source univention-directory-listener && \
  cd univention-directory-listener-* && \
  patch -p3 < /root/0001-allow-to-specify-separate-notifier-address.patch && \
  dpkg-buildpackage -uc -us -b


FROM ucs-sources-base AS final

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN \
  echo "postfix postfix/main_mailer_type string 'Satellite system'" \
  | debconf-set-selections && \
  echo "postfix postfix/mailname string univention-directory-listener" \
  | debconf-set-selections && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
  postfix

COPY --from=deb_builder \
  /root/src/debian/univention-directory-listener_*.deb /root/

# hadolint ignore=DL3008
RUN \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
  /root/univention-directory-listener_*.deb \
  python3-distutils \
  python3-univention-directory-manager && \
  awk \
  '/^Package: univention-directory-listener$/{ while(!/^Version: /){getline} print $2 }' \
  /var/lib/dpkg/status > /version

RUN \
  rm /usr/lib/univention-directory-listener/system/*

COPY ./command.sh /
COPY ./listener-base-entrypoint.envsh /entrypoint.d/50-listener-base-entrypoint.envsh

CMD ["/command.sh"]


FROM final AS debug

COPY ./listener_handler.py /usr/lib/univention-directory-listener/system/
