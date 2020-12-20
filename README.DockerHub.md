# mikenye/rawflight

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/mikenye/docker-rawflight/Deploy%20to%20Docker%20Hub)](https://github.com/mikenye/docker-rawflight/actions?query=workflow%3A%22Deploy+to+Docker+Hub%22)
[![Docker Pulls](https://img.shields.io/docker/pulls/mikenye/rawflight.svg)](https://hub.docker.com/r/mikenye/rawflight)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/mikenye/rawflight/latest)](https://hub.docker.com/r/mikenye/rawflight)
[![Discord](https://img.shields.io/discord/734090820684349521)](https://discord.gg/sTf9uYF)

Docker container to feed ADS-B data to [RawFlight.eu](https://rawflight.eu). Designed to work in tandem with `mikenye/readsb-protobuf` or another BEAST provider. Builds and runs on i386, x86_64, arm32v6, arm32v7 & arm64.

The container pulls ADS-B information from the `mikenye/readsb-protobuf` container (or another host providing data in BEAST format) and sends data to RawFlight.eu.

## Documentation

Please [read this container's detailed and thorough documentation in the GitHub repository.](https://github.com/mikenye/docker-rawflight/blob/main/README.md)