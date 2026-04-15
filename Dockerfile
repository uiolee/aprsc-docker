ARG APRSC_GITREF="main"

FROM alpine:latest AS build-base

RUN apk add --no-cache build-base libevent-dev libevent-static perl \
  git

# ===================================================================

FROM build-base AS builder
ARG APRSC_GITREF

WORKDIR /tmp/build/
COPY ./.git ./.git
COPY ./aprsc ./aprsc

WORKDIR /tmp/build/aprsc
RUN git checkout -f $APRSC_GITREF

RUN adduser -D -u 1000 -h /opt/aprsc aprsc

WORKDIR /tmp/build/aprsc/src/
RUN ./configure --prefix=/opt/aprsc LDFLAGS="-static" CFLAGS="-O2"
RUN make
RUN make install

WORKDIR /opt/aprsc/
RUN file ./sbin/aprsc && \
  ldd ./sbin/aprsc && \
  readelf -h ./sbin/aprsc && \
  readelf -d ./sbin/aprsc && \
  scanelf -n ./sbin/aprsc 

RUN tree /opt/aprsc/

RUN chown -R aprsc:aprsc /opt/aprsc/

# ===================================================================

FROM scratch
ARG APRSC_GITREF

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /opt/aprsc /opt/aprsc

WORKDIR /opt/aprsc
ENTRYPOINT ["/opt/aprsc/sbin/aprsc"]

CMD ["-t","/opt/aprsc","-u","aprsc","-c", "etc/aprsc.conf","-e", "info", "-o", "stderr"]
# DONT add `-f` to the command.

VOLUME ["/opt/aprsc/data/"]
VOLUME ["/opt/aprsc/etc/"]
VOLUME ["/opt/aprsc/logs/"]

EXPOSE 8080/tcp
EXPOSE 10152/tcp
EXPOSE 14501/tcp
EXPOSE 14580/tcp

EXPOSE 8080/udp
EXPOSE 10152/udp
EXPOSE 14580/udp

LABEL org.opencontainers.image.authors="uiolee"
LABEL org.opencontainers.image.description="Docker Images of aprsc"
LABEL org.opencontainers.image.licenses="MPL-2.0"
LABEL org.opencontainers.image.source="https://github.com/uiolee/aprsc-docker"
LABEL org.opencontainers.image.title="aprsc"
LABEL org.opencontainers.image.url="https://github.com/uiolee/aprsc-docker"
LABEL org.opencontainers.image.version="0.2.3"
LABEL aprsc.gitref="$APRSC_GITREF"
