ARG DOCKER_PROXY
ARG DEBIAN_BASE_IMAGE_TAG=buster-slim

# TODO: Should become a base image
# See also "minbase" and similar from "DIST/docker-services" on Gitlab
FROM ${DOCKER_PROXY}debian:${DEBIAN_BASE_IMAGE_TAG} AS ucs-sources-base
ARG APT_KEY_URL=https://updates.software-univention.de/univention-archive-key-ucs-5x.gpg

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get --assume-yes --verbose-versions --no-install-recommends install \
      ca-certificates \
      curl \
      gpg \
      gpg-agent \
      libterm-readline-gnu-perl \
    && rm -fr /var/lib/apt/lists/*  /var/cache/apt/archives/* \
    && curl -fsSL ${APT_KEY_URL} | apt-key add -

COPY sources.list /etc/apt/sources.list.d/15_ucs-online-version.list


FROM ucs-sources-base as deb_builder

COPY patches/ /root/

WORKDIR /root/src/debian/

# hadolint ignore=DL3003
RUN \
  apt-get update && \
  apt-get build-dep --assume-yes univention-directory-listener && \
  apt-get source univention-directory-listener && \
  cd univention-directory-listener-* && \
  patch -p3 < /root/separate_notifier_address.patch && \
  dpkg-buildpackage -uc -us -b && \
  apt-get  --assume-yes --verbose-versions --no-install-recommends install \
    /root/src/debian/univention-directory-listener_*.deb && \
  rm -rf /var/lib/apt/lists/*


FROM ucs-sources-base

ARG LABEL_CREATED=undefined
ARG LABEL_REVISION=undefined
ARG LABEL_SOURCE=undefined
ARG LABEL_VERSION=undefined

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
  rm -rf /var/lib/apt/lists/*

COPY --from=deb_builder \
    /root/src/debian/univention-directory-listener_*.deb /root/

# hadolint ignore=DL3008
RUN \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    /root/univention-directory-listener_*.deb \
    python3-distutils \
    python3-univention-directory-manager && \
  rm -rf /var/lib/apt/lists/* && \
  awk \
    '/^Package: univention-directory-listener$/{ while(!/^Version: /){getline} print $2 }' \
    /var/lib/dpkg/status > /version

RUN \
  rm /usr/lib/univention-directory-listener/system/*

# TODO: Split into separate stage, so that we have a base listener without any handler
COPY \
  ./listener_handler.py \
  /usr/lib/univention-directory-listener/system/

COPY ./command.sh /

CMD ["/command.sh"]

# TODO: Remove or update
LABEL org.opencontainers.image.created="${LABEL_CREATED}"
LABEL org.opencontainers.image.description="Web service for Univention Management Console"
LABEL org.opencontainers.image.licenses="AGPL-3.0-or-later"
LABEL org.opencontainers.image.revision=$LABEL_REVISION
LABEL org.opencontainers.image.source="${LABEL_SOURCE}"
LABEL org.opencontainers.image.title="udm-rest"
LABEL org.opencontainers.image.url="https://docs.software-univention.de/developer-reference-4.4.html#chap:umc"
LABEL org.opencontainers.image.vendor="Univention GmbH"
LABEL org.opencontainers.image.version="${LABEL_VERSION}"

# [EOF]
