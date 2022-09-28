ARG BASE="alpine"
ARG VERSION="3.16"
FROM ${BASE}:${VERSION}

# adds file from the shinsenter/s6-overlay image
COPY --from=shinsenter/s6-overlay / /

## add PUID and PGID support
COPY 10-adduser /etc/cont-init.d/10-adduser

RUN groupmod -g 1000 users && \
    useradd -u 911 -U -d /app -s /bin/false abc && \
    usermod -G users abc

# important: sets s6-overlay entrypoint
ENTRYPOINT ["/init"]
