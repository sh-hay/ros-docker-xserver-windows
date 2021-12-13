# Docker で GUI を表示して，ROSパッケージを開発する．

WSL2で起動したDockerコンテナ内のGUIアプリを表示する．

[ROS wiki / docker / Tutorials / GUI](http://wiki.ros.org/docker/Tutorials/GUI)によるとDockerでGUIを表示する方法はいくつかあるが，どれも一長一短であるらしい．

Windowsで主流な方法は以下3通りほどあるようだが，今回はXserverを使用する．
- VNC (描画が遅い)
- Windows 11 の WSL2g（2021.12.13時点でInsider build 版のみ）
- Xserver

## 動作を確認した環境
- Windows 10 Home/Pro
- 20H2

## 準備 / Windows側にXサーバーをインストールし，起動
Windows用のXサーバーアプリとして、VcXsrvをインストール  
https://sourceforge.net/projects/vcxsrv/

VcXsrvの設定方法は[ここ](https://astherier.com/blog/2020/08/run-gui-apps-on-wsl2/#:~:text=on%2Dwindows%2D1...-,Windows%E5%81%B4%E3%81%ABX%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB,-WSL2%E4%B8%8A%E3%81%AEUbuntu)を参考．下記注意点以外は初期設定でOK  

__注意点__
- Additional parameters for VcXsrvに「-ac -nowgl」を指定
- ファイアウォールでは「パブリックネットワーク」も許可

__VcXsrvのインストール__  
- 初期設定でOK


__XLaunchの設定__
- Display setting
  - Multiple windows
  - Display number [0] (変更)
- Client startup
  - Start no client
- Extra settings
  - [x] clipboard
    - [x] Primary Selection
  - [x] Native opengl
  - [ ] Disable access control
  - Additional parameters for VcXsev [-ac -nowgl] (変更)


## 実行
```bash
# WSL のターミナルにて
cd （任意のディレクトリ）
git clone git@github.com:sh-hay/ros-docker-xserver-windows.git

cd ros-docker-xserver-windows
docker build -t xserver_image .
  # -t xserver_image
  # ビルドする Docker image 名

  # .
  # カレントディレクトリ内の Dockerfile を使用


docker run -it --rm --name xserver_container xserver_image roslaunch /turtlesim.launch
  # --it
  # 標準入出力受付

  # --rm
  # コンテナ終了時に自動で起動したコンテナを削除する

  # --name xserver_container
  # 起動するコンテナ名を xserver_container とする（なんでもOK）

  # xserver_image
  # Docker image 名． 上の build コマンドで作成した．

  # roslaunch /turtlesim.launch
  # コンテナ起動時に実行するコマンド．何もつけなければ今回は bash が起動

```

カメさんが出ればOK  
Docker コンテナ内の別のターミナルを起動するには
```bash
# 新しいWSL2ターミナルで
docker exec -it xserver_container bash
```

## コンテナ開発
```bash
# WSL2ターミナルで
cd ros-docker-xserver-windows
docker run -it --rm --volume ${PWD}/DockerUser:/home/DockerUser --name xserver_container xserver_image
  # --volume ${PWD}/DockerUser:/home/DockerUser
  # コンテナは実行環境から隔離されるため，[ホスト内のディレクトリ]:[コンテナ内のディレクトリ]で指定して同期する


# コンテナ内のターミナルで

# rvizでURDFモデルを表示
cd /home/DockerUser/catkin_ws/src/tortoisebot/src/urdf/
roslaunch urdf_tutorial display.launch model:=tortoisebot.urdf
```

## ロボット自律移動

https://user-images.githubusercontent.com/58795536/145796012-2f7bf713-270b-4dd9-bbb1-93ed43ff5c57.mp4

```
cd ros-docker-xserver-windows
docker run -it --rm --volume ${PWD}/DockerUser:/home/DockerUser --name xserver_container xserver_image roslaunch tortoisebot tortoisebot.launch


```


## 参考
https://astherier.com/blog/2020/08/run-gui-apps-on-wsl2/

https://github.com/osrf/rosbook/tree/master/code/tortoisebot