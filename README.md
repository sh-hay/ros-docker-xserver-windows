# Docker で GUI を表示する．

WSL2で起動したDockerコンテナ内のGUIアプリを表示する．

[ROS wiki / docker / Tutorials / GUI](http://wiki.ros.org/docker/Tutorials/GUI)によるとDockerでGUIを表示する方法はいくつかあるが，どれも一長一短であるらしい．


## 環境
- Windows 10 Pro
- 20H2

## 準備/Windows側にXサーバーをインストール
Windows用のXサーバーアプリとして、VcXsrvをインストール  
https://sourceforge.net/projects/vcxsrv/

VcXsrvの設定方法はサイトを参考．下記注意点以外は初期設定でOK  
注意点
- Additional parameters for VcXsrvに「-ac -nowgl」を指定
- ファイアウォールでは「パブリックネットワーク」も許可


```bash
cd （任意のディレクトリ）
git clone https://github.com/sh-hay/ros-docker-xserver-windows.git

docker build -t xserver_test .

docker run -it --rm xserver_test # --rmはコンテナ終了時に自動で削除するオプション

```

## 参考
https://astherier.com/blog/2020/08/run-gui-apps-on-wsl2/