ARG BASE="alpine"
ARG VERSION="3.16"
FROM ${BASE}:${VERSION}

# adds file from the shinsenter/s6-overlay image
COPY --from=shinsenter/s6-overlay:v3.1.4.2 / /

# Tweak for alpine
RUN if [ -x "$(command -v apk)" ] ; then apk add --no-cache bash shadow ; fi

## add PUID and PGID support
COPY 10-adduser /etc/cont-init.d/10-adduser
RUN groupadd --gid 1000 abc && \
    useradd -u 1000 -g 1000 --create-home -d /app -s /bin/false abc

# important: sets s6-overlay entrypoint
ENTRYPOINT ["/init"]
