__CROSS__FROM alpine AS builder

__CROSS__ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-__QEMU_ARCH__.tar.gz
__CROSS__RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM __DOCKER_ARCH__/ros:melodic-ros-base

__CROSS__COPY --from=builder qemu-__QEMU_ARCH__-static /usr/bin

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