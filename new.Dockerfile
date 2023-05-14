###############################################################################
# Builder image for patched univention-directory-listener
###############################################################################
ARG DOCKERHUB_CACHE
ARG DEBIAN_BASE_IMAGE_TAG
FROM ${DOCKERHUB_CACHE}debian:${DEBIAN_BASE_IMAGE_TAG} AS deb_builder

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

WORKDIR /root/src/debian/

RUN \
  echo 'debconf debconf/frontend select readline' | debconf-set-selections && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    ca-certificates curl gpg gpg-agent libterm-readline-gnu-perl && \
  rm -rf /var/lib/apt/lists/*

COPY sources.list /etc/apt/sources.list.d/15_ucs-online-version.list
COPY patches/ /root/

RUN \
  chown _apt . && \
  # TODO: causing trouble when building locally, why would we need this?
  # echo 'nameserver 192.168.0.97' > /etc/resolv.conf && \
  printf -v URL '%s' \
    'https://updates.software-univention.de/' \
    'univention-archive-key-ucs-5x.gpg' && \
  curl -fsSL "${URL}" | apt-key add - && \
  apt-get update && \
  apt-get build-dep --assume-yes univention-directory-listener && \
  apt-get source univention-directory-listener && \
  cd univention-directory-listener-* && \
  patch -p3 < /root/separate_notifier_address.patch && \
  dpkg-buildpackage -uc -us -b && \
  apt-get  --assume-yes --verbose-versions --no-install-recommends install \
    /root/src/debian/univention-directory-listener_*.deb && \
  rm -rf /var/lib/apt/lists/*

###############################################################################
# Final image
###############################################################################
ARG DOCKERHUB_CACHE
ARG DEBIAN_BASE_IMAGE_TAG
FROM ${DOCKERHUB_CACHE}debian:${DEBIAN_BASE_IMAGE_TAG}

ARG LABEL_CREATED=undefined
ARG LABEL_REVISION=undefined
ARG LABEL_SOURCE=undefined
ARG LABEL_VERSION=undefined

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

###############################################################################
# dependencies
###############################################################################

RUN \
  echo 'debconf debconf/frontend select readline' | debconf-set-selections && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    ca-certificates curl gpg gpg-agent libterm-readline-gnu-perl && \
  rm -rf /var/lib/apt/lists/*

###############################################################################
# postfix
###############################################################################

RUN \
  echo "postfix postfix/main_mailer_type string 'Satellite system'" \
    | debconf-set-selections && \
  echo "postfix postfix/mailname string univention-directory-listener" \
    | debconf-set-selections && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    postfix && \
  rm -rf /var/lib/apt/lists/*

###############################################################################
# listener
###############################################################################

COPY sources.list /etc/apt/sources.list.d/15_ucs-online-version.list
COPY --from=deb_builder \
    /root/src/debian/univention-directory-listener_*.deb /root/

RUN \
  # TODO: Causing trouble when building locally, why is this needed?
  # echo 'nameserver 192.168.0.97' > /etc/resolv.conf && \
  printf -v URL '%s' \
    'https://updates.software-univention.de/' \
    'univention-archive-key-ucs-5x.gpg' && \
  curl -fsSL "${URL}" | apt-key add - && \
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

COPY \
  ./listener_handler.py \
  /usr/lib/univention-directory-listener/system/

COPY ./command.sh /

CMD ["/command.sh"]

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
