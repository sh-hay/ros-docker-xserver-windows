#!/bin/bash
set -e

# sudo chmod 666 /dev/video0

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
exec "$@"
