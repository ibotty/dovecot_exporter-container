FROM alpine:3.7

ENV DOVECOT_EXPORTER_VERSION=0.1.1

RUN apk update \
 && apk add ca-certificates git go libc-dev \
 && update-ca-certificates \
 && wget -O - https://github.com/kumina/dovecot_exporter/archive/${DOVECOT_EXPORTER_VERSION}.tar.gz | tar xzf - \
 && cd "dovecot_exporter-$DOVECOT_EXPORTER_VERSION" \
 && export GOPATH=/gopath \
 && go get -d ./... \
 && go build --ldflags '-extldflags "-static"' \
 && strip dovecot_exporter
