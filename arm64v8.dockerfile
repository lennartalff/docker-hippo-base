FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-aarch64.tar.gzRUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm32v7/ros:melodic-ros-base

# Add QEMU
COPY --from=builder qemu-aarch64-static /usr/bin

RUN apt-get update && apt-get install -yq \
    python-catkin-tools \
    avahi-daemon \
    avahi-utils \
    libnss-mdns \
    && rm -rf /var/lib/apt/lists/

COPY avahi-daemon.conf /etc/avahi/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]