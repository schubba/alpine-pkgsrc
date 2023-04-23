FROM alpine:latest

MAINTAINER Justin Cormack <justin@specialbusservice.com>

RUN \
  apk update && \
  apk upgrade && \
  apk add \
  build-base \
  gawk \
  tar \
  grep \
  gzip \
  bzip2 \
  sed \
  zlib-dev \
  openssl-dev \
  ncurses-dev \
  file \
  wget \
  git \
  cvs \
  rsync \
  m4 \
  bash \
  gmp-dev \
  openssh \
  curl \
  linux-headers

RUN \
      mkdir -p ~/.ssh && \
      ssh-keyscan -H anoncvs.NetBSD.org > ~/.ssh/known_hosts && \
      cd /usr && \
      cvs -q -z2 -d anoncvs@anoncvs.NetBSD.org:/cvsroot checkout -P pkgsrc

ENV \
  PATH=/usr/pkg/bin:$PATH \
  NOGCCERROR=yes \
  PKG_DEFAULT_OPTIONS="-gssapi" \
  LIBABISUFFIX=""

RUN \
  cd /usr/pkgsrc/bootstrap && ./bootstrap 
  
COPY mk.conf /usr/pkg/etc/
