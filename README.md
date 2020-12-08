# mikenye/rawflight

Docker container to feed ADS-B data to [RawFlight.eu](https://rawflight.eu). Designed to work in tandem with `mikenye/readsb-protobuf` or another BEAST provider. Builds and runs on i386, x86_64, arm32v6, arm32v7 & arm64v8.

The container pulls ADS-B information from the `mikenye/readsb-protobuf` container (or another host providing data in BEAST format) and sends data to RawFlight.eu.

## Supported tags and respective Dockerfiles

* `latest` is built nightly from the [`main` branch](https://github.com/mikenye/docker-rawflight/tree/main) [`Dockerfile`](https://github.com/mikenye/docker-rawflight/blob/main/Dockerfile) for all supported architectures.
* `latest_nohealthcheck` is the same as the `latest` version above. However, this version has the docker healthcheck removed. This is done for people running platforms (such as [Nomad](https://www.nomadproject.io)) that don't support manually disabling healthchecks, where healthchecks are not wanted.

## Up-and-Running with `docker run`

```shell
docker run \
 -d \
 --it \
 --restart always \
 --name rawflight \
 -e TZ=Australia/Perth \
 -e BEASTHOST=readsb \
 mikenye/rawflight
```

Set `BEASTHOST` and `TIMEZONE` accordingly for your environment.

## Up-and-Running with Docker Compose

```yaml
version: '2.0'

services:
  rawflight:
    image: mikenye/rawflight
    tty: true
    container_name: rawflight
    restart: always
    environment:
      - BEASTHOST=readsb
      - TZ=Australia/Perth
```

Set `BEASTHOST` and `TIMEZONE` accordingly for your environment.

## Runtime Environment Variables

There are a series of available environment variables:

| Environment Variable | Purpose                                                                  | Default |
| -------------------- | ------------------------------------------------------------------------ | ------- |
| `BEASTHOST`          | Required. IP/Hostname of a Mode-S/BEAST provider (readsb/dump1090)       |         |
| `BEASTPORT`          | Optional. TCP port number of Mode-S/BEAST provider (readsb/dump1090)     | `30005` |
| `TZ`                 | Optional. Local timezone in ["TZ database name" format](<https://en.wikipedia.org/wiki/List_of_tz_database_time_zones>). | `GMT` |

## Ports

No inbound ports are used.

## Logging

All processes are logged to the container's stdout, and can be viewed with `docker logs [-f] container`.

## Getting help

Please feel free to [open an issue on the project's GitHub](https://github.com/mikenye/docker-rawflight/issues).

I also have a [Discord channel](https://discord.gg/sTf9uYF), feel free to [join](https://discord.gg/sTf9uYF) and converse.

## Changelog

See the [commit history](https://github.com/mikenye/docker-rawflight/commits/main) on GitHub.
