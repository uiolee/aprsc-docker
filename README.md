# aprsc-docker

[![Docker Image CI](https://github.com/uiolee/aprsc-docker/actions/workflows/ci.yml/badge.svg?event=push)](https://github.com/uiolee/aprsc-docker/actions/workflows/ci.yml)
[![GitHub Tag](https://img.shields.io/github/v/tag/uiolee/aprsc-docker)](#)
[![GitHub commits since latest release](https://img.shields.io/github/commits-since/uiolee/aprsc-docker/latest)](#)

Run the built aprsc binary in docker

## docker image

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/uiolee/aprsc/latest)][dockerhub]
[![Docker Pulls](https://img.shields.io/docker/pulls/uiolee/aprsc)][dockerhub]
[![Docker Stars](https://img.shields.io/docker/stars/uiolee/aprsc)][dockerhub]

- [https://hub.docker.com/r/uiolee/aprsc/][dockerhub]
- [https://github.com/uiolee/aprsc-docker/pkgs/container/aprsc][githubpackage]

> [!NOTE]
>
> You need to manually add your own ![`aprsc.conf`](./_data/etc/aprsc.conf) to VOLUME first, otherwise the program will fail to start.
>
> See [hessu/aprs/doc/CONFIGURATION.md](https://github.com/hessu/aprsc/blob/main/doc/CONFIGURATION.md) for more detail.

## docker compose

[./docker-compose.yml](./docker-compose.yml)

[dockerhub]: https://hub.docker.com/r/uiolee/aprsc
[githubpackage]: https://github.com/uiolee/aprsc-docker/pkgs/container/aprsc
