# aprsc-docker

Docker Images of [aprsc](https://github.com/hessu/aprsc/), built in Alpine and run in Scratch.

[![Docker Image CI](https://github.com/uiolee/aprsc-docker/actions/workflows/ci.yml/badge.svg?event=push)](https://github.com/uiolee/aprsc-docker/actions/workflows/ci.yml)
[![GitHub Tag](https://img.shields.io/github/v/tag/uiolee/aprsc-docker)](#)

## Images

[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/uiolee/aprsc/latest)][dockerhub]
[![Docker Pulls](https://img.shields.io/docker/pulls/uiolee/aprsc)][dockerhub]
[![Docker Stars](https://img.shields.io/docker/stars/uiolee/aprsc)][dockerhub]

Images avaliable in registries:

| Registry                         | Tag                             |
| -------------------------------- | ------------------------------- |
| [Github Packages][githubpackage] | `ghcr.io/uiolee/aprsc:latest`   |
| [Docker Hub][dockerhub]          | `docker.io/uiolee/aprsc:latest` |

> [!NOTE]
>
> You need to manually add your own [`aprsc.conf`](./_data/etc/aprsc.conf) to VOLUME first, otherwise the program will fail to start.

## Docker Compose

Example: [`./docker-compose.yml`](./docker-compose.yml)

## Example Usage

```sh
git clone git@github.com:uiolee/aprsc-docker.git -d 1
cd aprsc-docker
docker compose up
```

[dockerhub]: https://hub.docker.com/r/uiolee/aprsc
[githubpackage]: https://github.com/uiolee/aprsc-docker/pkgs/container/aprsc
