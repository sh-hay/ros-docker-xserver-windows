#!/bin/bash
set -e

# setup display environment
if [ "${OS}" = "linux" ];then
  echo "linux environment"
else
  echo "windows environment"
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
  echo "export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0" >> ${HOME}/.bashrc

fi

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ${HOME}/.bashrc

cd /home/DockerUser/catkin_ws && \
/bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make"

source "${HOME}/catkin_ws/devel/setup.bash"
echo "source ~/catkin_ws/devel/setup.bash" >> ${HOME}/.bashrc

exec "$@"
