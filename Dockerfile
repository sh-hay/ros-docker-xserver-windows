FROM osrf/ros:melodic-desktop-bionic
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-melodic-desktop-full=1.4.1-0* \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    xserver-xorg \
    # x11-apps \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ros-melodic-joint-state-publisher \
    ros-melodic-joint-state-publisher-gui \
    ros-melodic-robot-state-publisher \
    ros-melodic-slam-gmapping \
    ros-melodic-map-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/DockerUser DockerUser -p $(perl -e 'print crypt("DockerUser", "salt"),"\n"') && \
    echo "DockerUser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV USER DockerUser
USER DockerUser

RUN mkdir -p /home/DockerUser/catkin_ws/src && \
    cd /home/DockerUser/catkin_ws/src && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash; /opt/ros/melodic/bin/catkin_init_workspace" && \
    cd /home/DockerUser/catkin_ws && \
    /bin/bash -c "source /opt/ros/melodic/setup.bash; catkin_make"
    # echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
    # echo "source /home/catkin_ws/devel/setup.bash" >> ~/.bashrc

COPY ./ros_entrypoint.sh /
COPY ./turtlesim.launch /
ENTRYPOINT ["/ros_entrypoint.sh"]

# CMD ["roslaunch", "/turtlesim.launch"]
CMD ["bash"]