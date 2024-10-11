# SSH-Forwarder image

This container image contains a ssh installation and allows forwarding of remote or local TCP ports.

## Installation

1. Pull from [Docker Hub], download the package from [Releases] or build using `builder/build.sh`

## Usage

This Container image extends the [base image].

### Environment variables

-   `SERVER_KEY`
    -   SSH key to use for authorization to the server.
-   `SERVER_URL`
    -   Server to connect to in the format ` ssh://[user@]hostname[:port]`.
-   `SERVER_IDENTITY`
    -   Public key of the server for host key checking.
-   `FORWARD_DIRECTION`
    -   Where to forward. `remote` to forward connections to a port on the local machine to a remote
        port. `local` to forward connections to a port on the remote machine to a local port.
-   `SOURCE_ADDRESS`
    -   Source address in the format `HOST:PORT`.
-   `TARGET_ADDRESS`
    -   Target address in the format `HOST:PORT`.

## Development

To run for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[base image]: https://github.com/mbT-Infrastructure/docker-base
[Docker Hub]: https://hub.docker.com/r/madebytimo/ssh-forwarder
[Releases]: https://github.com/mbT-Infrastructure/docker-ssh-forwarder/releases
