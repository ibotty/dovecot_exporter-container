FROM alpine:3.7

ENV DOVECOT_EXPORTER_VERSION=0.1.3

# hack to let it build when option ndots:5 is set, which is not supported by muslc
RUN sed '/ ndots:/d' /etc/resolv.conf > /tmp/resolv.conf \
 && cat /tmp/resolv.conf > /etc/resolv.conf \
 && apk update \
 && apk add ca-certificates git go libc-dev \
 && update-ca-certificates \
 && wget -O - https://github.com/kumina/dovecot_exporter/archive/${DOVECOT_EXPORTER_VERSION}.tar.gz | tar xz \
 && cd "dovecot_exporter-$DOVECOT_EXPORTER_VERSION" \
 && export GOPATH=/gopath \
 && go get -d ./... \
 && go build --ldflags '-extldflags "-static"' \
 && mv "dovecot_exporter-$DOVECOT_EXPORTER_VERSION" /dovecot_exporter \
 && strip /dovecot_exporter
