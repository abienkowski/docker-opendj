# -- depend on alpine server-jre oracle release 7
FROM java:7-jre-alpine
# -- set environment variables
ENV OPENDJ_VERSION=2.6.2 \
    OPENDJ_HOME=/opt/opendj \
    OPENDJ_DOWNLOAD_URL=https://github.com/OpenRock/OpenDJ/releases/download
# -- upgrade and remove all cache
RUN apk update \
 && apk upgrade \
 && apk add --no-cache curl \
 && mkdir -p /opt \
 && curl -o /opt/opendj.zip -fSL ${OPENDJ_DOWNLOAD_URL}/${OPENDJ_VERSION}/opendj-server-${OPENDJ_VERSION}.zip \
 && unzip -d /opt /opt/opendj.zip \
 && rm /opt/opendj.zip \
 && mkdir -p $OPENDJ_HOME/locks \
 && rm -rf /var/cache/apk/* /var/lib/apk/* /etc/apk/cache/*
# -- external volumes that should be mounted
# /opt/opendj/db - stores all databases
# /opt/opendj/logs - stores log files
# /opt/opendj/bak - stores backups
# -- --
# -- entrypoint for the image
ENTRYPOINT ["$OPENDJ_HOME/bin/start-ds", "--nodetach"]
