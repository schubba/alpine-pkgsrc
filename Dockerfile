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
  rsync \
  m4 \
  bash \
  gmp-dev \
  zsh\
  curl
  linux-headers

RUN \
  cd /usr && \
  git clone https://github.com/jsonn/pkgsrc.git 

ENV \
  PATH=/usr/pkg/bin:$PATH \
  NOGCCERROR=yes \
  PKG_DEFAULT_OPTIONS="-gssapi" \
  LIBABISUFFIX=""

RUN \
  cd /usr/pkgsrc/bootstrap && ./bootstrap \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
COPY mk.conf /usr/pkg/etc/
