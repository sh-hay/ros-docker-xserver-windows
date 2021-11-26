# Docker で GUI を表示する．

WSL2で起動したDockerコンテナ内のGUIアプリを表示する．

[ROS wiki / docker / Tutorials / GUI](http://wiki.ros.org/docker/Tutorials/GUI)によるとDockerでGUIを表示する方法はいくつかあるが，どれも一長一短であるらしい．

Windowsで主流な方法は3通りほどあるようだが，今回はXserverを使用する．

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
cd （任意のディレクトリ）
git clone https://github.com/sh-hay/ros-docker-xserver-windows.git

docker build -t xserver_image .

docker run -it --rm --name xserver_container xserver_image # --rmはコンテナ終了時に自動で削除するオプション
```

カメさんが出ればOK  
別のターミナルを起動するには
```bash
docker exec -it xserver_container bash
```


## 参考
https://astherier.com/blog/2020/08/run-gui-apps-on-wsl2/