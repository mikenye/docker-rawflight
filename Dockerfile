FROM debian:stable-slim

ENV BEASTPORT=30005 \
    RAWFLIGHTHOST=rawflight.eu \
    RAWFLIGHTPORT=48581
    
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -x && \
    TEMP_PACKAGES=() && \
    KEPT_PACKAGES=() && \
    # Dependencies for feeding rawflight
    KEPT_PACKAGES+=(pv) && \
    KEPT_PACKAGES+=(socat) && \
    # Dependencies for installing s6-overlay
    TEMP_PACKAGES+=(ca-certificates) && \
    TEMP_PACKAGES+=(curl) && \
    TEMP_PACKAGES+=(file) && \
    TEMP_PACKAGES+=(gnupg) && \
    # Install packages
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ${KEPT_PACKAGES[@]} \
        ${TEMP_PACKAGES[@]} \
        && \
    # Deploy s6-overlay
    curl -s https://raw.githubusercontent.com/mikenye/deploy-s6-overlay/master/deploy-s6-overlay.sh | sh && \
    # Clean up
    apt-get remove -y ${TEMP_PACKAGES[@]} && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /src /tmp/* /var/lib/apt/lists/* && \
    find /var/log -type f -iname "*log" -exec truncate --size 0 {} \;

COPY rootfs/ /
