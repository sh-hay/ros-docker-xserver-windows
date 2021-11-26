FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xserver-xorg \
    x11-apps \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

RUN useradd -m -d /home/DockerUser DockerUser -p $(perl -e 'print crypt("DockerUser", "salt"),"\n"') && \
    echo "DockerUser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

ENV USER DockerUser
USER DockerUser

COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["xeyes"]