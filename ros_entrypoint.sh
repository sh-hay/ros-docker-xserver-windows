#!/bin/bash
set -e

# setup ros environment
# source "/opt/ros/$ROS_DISTRO/setup.bash"

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0

exec "$@"
