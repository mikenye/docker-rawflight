#!/usr/bin/env bash
#shellcheck shell=bash

REPO=mikenye
IMAGE=rawflight
PLATFORMS="linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64"
LATEST_TAG=latest

docker context use x86_64
export DOCKER_CLI_EXPERIMENTAL="enabled"
docker buildx use homecluster

# Build & push latest
EXITCODE=1
FIRSTRUN=1
TRIES=1
while [[ "$EXITCODE" -ne 0 ]]; do
    echo "Attempting build, try $TRIES"
    if [[ "$FIRSTRUN" -eq 1 ]]; then
        docker buildx build --no-cache -t "${REPO}/${IMAGE}:${LATEST_TAG}" --compress --push --platform "${PLATFORMS}" .
        EXITCODE="$?"
        FIRSTRUN=0
    else
        docker buildx build -t "${REPO}/${IMAGE}:${LATEST_TAG}" --compress --push --platform "${PLATFORMS}" .
        EXITCODE="$?"
    fi
    TRIES=$((TRIES+1))
    if [[ "$TRIES" -ge 5 ]]; then
        exit 1
    fi
done

# BUILD NOHEALTHCHECK VERSION
# Modify dockerfile to remove healthcheck
sed '/^HEALTHCHECK /d' < Dockerfile > Dockerfile.nohealthcheck

# Build & push latest
docker buildx build -f Dockerfile.nohealthcheck -t "${REPO}/${IMAGE}:${LATEST_TAG}_nohealthcheck" --compress --push --platform "${PLATFORMS}" .
