FROM bashell/alpine-bash
MAINTAINER Hussein Galal

ADD ./*.sh /opt/rancher/bin/
RUN chmod u+x /opt/rancher/bin/*.sh

RUN apk add linux-headers

# install dig and jq
RUN apk add -U alpine-sdk \
    && curl ftp://ftp.isc.org/isc/bind9/9.10.2/bind-9.10.2.tar.gz|tar -xzv \
    && cd bind-9.10.2 \
    && CFLAGS="-static" ./configure --without-openssl --disable-symtable \
    && make \
    && cp ./bin/dig/dig /opt/rancher/bin/ \
    && curl -L https://github.com/cloudnautique/giddyup/releases/download/v0.8.0/giddyup -o /opt/rancher/bin/giddyup \
    && chmod u+x /opt/rancher/bin/* \
    && apk del alpine-sdk \
    && rm -rf /var/cache/apk/* \
    && rm -rf /bind-9.10.2/

VOLUME /opt/rancher/bin
