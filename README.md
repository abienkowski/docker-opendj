# OpenDJ Docker Image

Provides ability to run opendj inside docker container with externally mounted volumes.

## Start the service with preexisting database and configuration found on external volumes

docker run -d \
    -v opendj-db:/opt/opendj/db \
    -v opendj-logs:/opt/opendj/logs \
    -v opendj-backup:/opt/opendj/bak \
    -v opendj-config:/opt/opendj/config \
    abienkowski/docker-opendj

### Optionally expose the ports to the host if needed

docker run -d \
    -p 389:389 -p 636:636 -p 4444:4444 \
    -v opendj-db:/opt/opendj/db \
    -v opendj-logs:/opt/opendj/logs \
    -v opendj-backup:/opt/opendj/bak \
    -v opendj-config:/opt/opendj/config \
    abienkowski/docker-opendj

## Initialize service with base configuration consider running the command bellow from a configuration mangement tools consider the following options
# 
docker run --rm -it \
    -v opendj-db:/opt/opendj/db \
    -v opendj-logs:/opt/opendj/logs \
    -v opendj-backup:/opt/opendj/bak \
    -v opendj-config:/opt/opendj/config \
    --entrypoint /bin/sh \
    abienkowski/docker-opendj \
    /opt/opendj/opendj/setup --cli \
        --hostname $SERVICE_FQDN \
        --ldapPort $LDAP_PORT \
        --ldapsPort $LDAPS_PORT \
        --adminConnectorPort LDAP_ADMIN_PORT \
        --enableStartTLS \
        --generateSelfSigneCertificate \
        --baseDN $BASE_DN \
        --addBaseEntry \
        --rootUserDN cn="Directory Manager" \
        --rootUserPassword `cat /opt/opendj/server.pin` \
        --no-prompt \
        --noPropertiesFile \
        --acceptLicense
