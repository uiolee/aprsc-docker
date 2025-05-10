FROM alpine:latest AS build-base

RUN apk add --no-cache build-base libevent-dev libevent-static perl

# ===================================================================

FROM build-base AS builder

WORKDIR /tmp/
COPY ./aprsc/ /tmp/aprsc-source/

RUN adduser -D -u 1000 aprsc && \
  mkdir -p /opt/aprsc && \
  chown -R aprsc:aprsc /opt/aprsc/

WORKDIR /tmp/aprsc-source/src/
RUN ./configure --prefix=/opt/aprsc LDFLAGS="-static" CFLAGS="-O2"
RUN make
RUN make install

WORKDIR /opt/aprsc/
RUN file /opt/aprsc/sbin/aprsc && \
  ldd /opt/aprsc/sbin/aprsc || echo "No dynamic dependencies"
RUN tree -apugD -L 2 /opt/aprsc/

RUN chown -R aprsc:aprsc /opt/aprsc/

# ===================================================================

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
COPY --from=builder /opt/aprsc /opt/aprsc

WORKDIR /opt/aprsc
ENTRYPOINT ["/opt/aprsc/sbin/aprsc"]

# CMD ["-u","aprsc","-t","/opt/aprsc","-e", "info", "-o", "file", "-r", "logs", "-c", "etc/aprsc.conf"]
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
LABEL org.opencontainers.image.description="Run the built aprsc binary in docker."
LABEL org.opencontainers.image.licenses="MPL-2.0"
LABEL org.opencontainers.image.source="https://github.com/uiolee/aprsc-docker"
LABEL org.opencontainers.image.title="aprsc"
LABEL org.opencontainers.image.url="https://github.com/uiolee/aprsc-docker"
LABEL org.opencontainers.image.version="0.2.0"
