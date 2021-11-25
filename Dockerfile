# This is an auto generated Dockerfile for ros:desktop-full
# generated from docker_images/create_ros_image.Dockerfile.em
FROM osrf/ros:melodic-desktop-bionic

# install ros packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*


RUN useradd -m -d /home/myUser myUser -p $(perl -e 'print crypt("myUser", "salt"),"\n"') && \
    echo "myUser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN \
  apt-get update && \
  apt-get -y install libgl1-mesa-glx libgl1-mesa-dri && \
  rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ros-melodic-usb-cam \
    ros-melodic-ar-track-alvar
    # \
    # ros-melodic-rosserial \
    # ros-melodic-rosserial-arduino \
    # ros-melodic-joy
# ros-melodic-uvc-camera 

RUN apt-get update && apt-get install -y \
    python-rosdep \
    python-rosinstall \
    python-rosinstall-generator \
    python-wstool \
    build-essential

# https://github.com/IntelRealSense/realsense-ros
# RUN apt-get update && apt-get install -y \
#     ros-melodic-realsense2-camera


# RUN apt-get update && apt-get -y upgrade

ENV QT_X11_NO_MITSHM 1

# setup entrypoint
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

ENV USER myUser
USER myUser

CMD ["bash"]
