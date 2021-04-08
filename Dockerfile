###############################################################################
# Single image
###############################################################################
ARG DEBIAN_BASE_IMAGE_TAG
FROM debian:${DEBIAN_BASE_IMAGE_TAG}

SHELL ["/bin/bash", "-c"]

###############################################################################
# dependencies
###############################################################################

RUN \
  set -euxo pipefail && \
  echo 'debconf debconf/frontend select readline' | debconf-set-selections && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    ca-certificates curl gpg gpg-agent libterm-readline-gnu-perl && \
  rm -rf /var/lib/apt/lists/*

###############################################################################
# postfix
###############################################################################

RUN \
  set -euxo pipefail && \
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

RUN \
  set -euxo pipefail && \
  echo 'nameserver 192.168.0.97' > /etc/resolv.conf && \
  printf -v URL '%s' \
    'https://updates.software-univention.de/' \
    'univention-archive-key-ucs-5x.gpg' && \
  curl -fsSL "${URL}" | apt-key add - && \
  apt-get update && \
  apt-get --assume-yes --verbose-versions --no-install-recommends install \
    python3-distutils \
    python3-univention-directory-manager \
    univention-directory-listener && \
  rm -rf /var/lib/apt/lists/*

RUN \
  rm /usr/lib/univention-directory-listener/system/*

COPY \
  ./listener_handler.py \
  /usr/lib/univention-directory-listener/system/

COPY ./command.sh /

CMD ["/command.sh"]

# [EOF]
