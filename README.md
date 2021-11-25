# このDockerfileについて
ROSでARマーカーをためす環境

- Ubuntu 18.04
- ROS melodic
- USBで接続
  - RealSense L515

```bash
cd ~/Container/16_l515

docker build -t 16_l515_image .


docker run  -it --rm \
    --name 16_l515 \
    --volume=/tmp/.X11-unix:/tmp/.X11-unix \
    --volume=$(pwd)/myUser:/home/myUser  \
    --privileged \
    --net=host \
    --env="DISPLAY=$DISPLAY"   \
    16_l515_image

    # --device=/dev/dri:/dev/dri \


# rosrun rosserial_python serial_node.py /dev/ttyACM0
roslaunch follow_ar_marker follow_ar_marker.launch
```


```bash
# rosrun usb_cam usb_cam_node
v4l2-ctl -d /dev/video6 --all
rosrun usb_cam usb_cam_node _video_device:=/dev/video6 _pixel_format:=yuyv
# rosrun uvc_camera uvc_camera_node
rosrun rqt_image_view rqt_image_view


    --device=/dev/ttyUSB0:/dev/ttyUSB0 \
```

環境構築メモ
[公式サイト](https://github.com/IntelRealSense/librealsense/blob/master/doc/distribution_linux.md)を参考にすすめる。

```
sudo apt-key adv --keyserver keys.gnupg.net --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE

sudo apt-get install software-properties-common
# 手順には無いが、add-apt-repositoryを追加

sudo add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo bionic main" -u

sudo apt-get install librealsense2-dkms
sudo apt-get install librealsense2-utils

```
https://qiita.com/porizou1/items/be1eb78015828d43f9fb

```bash
https://qiita.com/porizou1/items/be1eb78015828d43f9fb

cd realsense-ros/
git checkout `git tag | sort -V | grep -P "^2.\d+\.\d+" | tail -1`

sudo apt-get install ros-melodic-ddynamic-reconfigure

cd ~/my_catkin_ws/
catkin_make clean

export ROS_VER=melodic 
sudo apt-get install ros-$ROS_VER-realsense2-camera




sudo apt install ros-melodic-rtabmap ros-melodic-rtabmap-ros

```