FROM amd64/ros:melodic-ros-base

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