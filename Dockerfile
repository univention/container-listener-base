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
  echo 'nameserver 192.168.0.97' > /etc/resolv.conf && \
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
  echo 'nameserver 192.168.0.97' > /etc/resolv.conf && \
  printf -v URL '%s' \
    'https://updates.software-univention.de/' \
    'univention-archive-key-ucs-5x.gpg' && \
  curl -fsSL "${URL}" | apt-key add - && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    /root/univention-directory-listener_*.deb \
    python3-distutils \
    python3-univention-directory-manager && \
  rm -rf /var/lib/apt/lists/*

RUN \
  rm /usr/lib/univention-directory-listener/system/*

COPY \
  ./listener_handler.py \
  /usr/lib/univention-directory-listener/system/

COPY ./command.sh /

CMD ["/command.sh"]

# [EOF]
