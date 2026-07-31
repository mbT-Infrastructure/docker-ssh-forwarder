# SSH-Forwarder image

This container image contains a ssh installation and allows forwarding of remote or local TCP ports.

## Installation

1. Pull from [Docker Hub], download the package from [Releases] or build using `builder/build.sh`

## Usage

This Container image extends the [base image].

### Environment variables

- `SERVER_KEY`
    - SSH key to use for authorization to the server.
- `SERVER_URL`
    - Server to connect to in the format ` ssh://[user@]hostname[:port]`.
- `SERVER_IDENTITY`
    - Public key of the server for host key checking.
- `FORWARD_DIRECTION`, `FORWARD_DIRECTION_*`
    - Where to forward. `remote` to forward connections to a port on the local machine to a remote
      port. `local` to forward connections to a port on the remote machine to a local port.
    - Multiple can be defined by using a suffix (`_*`). The suffix has to be consistent with the one
      used for `SOURCE_ADDRESS` and `TARGET_ADDRESS`.
- `SOURCE_ADDRESS`, `SOURCE_ADDRESS_*`
    - Source address in the format `HOST:PORT`.
    - Multiple can be defined by using a suffix (`_*`). The suffix has to be consistent with the one
      used for `FORWARD_DIRECTION` and `TARGET_ADDRESS`.
- `TARGET_ADDRESS`, `TARGET_ADDRESS_*`
    - Target address in the format `HOST:PORT`.
    - Multiple can be defined by using a suffix (`_*`). The suffix has to be consistent with the one
      used for `FORWARD_DIRECTION` and `SOURCE_ADDRESS`.

## Development

To run for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[base image]: https://github.com/mbT-Infrastructure/docker-base
[Docker Hub]: https://hub.docker.com/r/madebytimo/ssh-forwarder
[Releases]: https://github.com/mbT-Infrastructure/docker-ssh-forwarder/releases
