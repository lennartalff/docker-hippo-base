#!/bin/bash

# start the avahi-daemon inside the container to resolve remote machines by hostname
service avahi-daemon start

# export the ros environment variables
source /opt/ros/$ROS_DISTRO/setup.bash

# set the ros hostname
export ROS_HOSTNAME=$(hostname).local

exec "$@"