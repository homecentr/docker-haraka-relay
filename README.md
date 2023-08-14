[![Project status](https://badgen.net/badge/project%20status/stable%20%26%20actively%20maintaned?color=green)](https://github.com/homecentr/docker-haraka-relay/graphs/commit-activity) [![](https://badgen.net/github/label-issues/homecentr/docker-haraka-relay/bug?label=open%20bugs&color=green)](https://github.com/homecentr/docker-haraka-relay/labels/bug) [![](https://badgen.net/github/release/homecentr/docker-haraka-relay)](https://hub.docker.com/repository/docker/homecentr/haraka-relay)
[![](https://badgen.net/docker/pulls/homecentr/haraka-relay)](https://hub.docker.com/repository/docker/homecentr/haraka-relay) 
[![](https://badgen.net/docker/size/homecentr/haraka-relay)](https://hub.docker.com/repository/docker/homecentr/haraka-relay)

![CI/CD on master](https://github.com/homecentr/docker-haraka-relay/workflows/CI/CD%20on%20master/badge.svg)


# Homecentr - haraka-relay

## Usage

```yml
version: "3.7"
services:
  haraka-relay:
    build: .
    image: homecentr/haraka-relay
    volumes:
      - .../auth_flat_file.ini:/haraka/config/auth_flat_file.ini
      - .../relay_via_external.ini:/haraka/config/relay_via_external.ini
      - .../tls_cert.pem:/haraka/config/tls_cert.pem
      - .../tls_key.pem:/haraka/config/tls_key.pem
```

## Exposed ports

| Port | Protocol | Description |
|------|------|-------------|
| 2525 | TCP | SMTP |
| 9904 | TCP | HTTP server with Prometheus metrics |

## Volumes

| Container path | Description |
|------------|---------------|
| /haraka | Haraka root directory |

## Security
The container is regularly scanned for vulnerabilities and updated. Further info can be found in the [Security tab](https://github.com/homecentr/docker-haraka-relay/security).

### Container user
The container runs as a non-root user with UID/GID 1000 by default.
