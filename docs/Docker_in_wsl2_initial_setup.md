# Windowsマシンでの開発環境構築

## 動作を確認した環境
Intel Core i7-8700  
Windows 10 Pro 20H2  
OSビルド 19042.1288  

## Windows に WSL2 インストール
https://docs.microsoft.com/ja-jp/windows/wsl/install
- Windows PowerShellを管理者で起動
- 以下コマンドを実行  
`wsl --install -d Ubuntu-20.04`
- 再起動

## Windows Terminalをインストール
https://atmarkit.itmedia.co.jp/ait/articles/2005/28/news018.html

- コマンドプロンプトや PowerShell でも WSL2 は使えるが，非常に使いにくい．
- このターミナルソフトは初期設定でも使いやすい．


## Docker インストール
https://docs.docker.com/engine/install/ubuntu/
- Windows Terminal から Ubuntu-20.04 を起動（起動時に Ubuntu が起動する設定も可能）
![windows_terminal](https://user-images.githubusercontent.com/58795536/146703739-ece78649-602e-44e2-aca5-28e50bfc11e1.png)
- 以下のコマンドで Docker をインストール
  
```bash
$ sudo apt-get update
$ sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

### Docker 動作確認
```bash
$ sudo service docker start
# docker daemon の起動．

$ sudo docker run hello-world # 以下のようなメッセージが表示されれば OK
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
d1725b59e92d: Pull complete
Digest: sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

## （任意）ターミナル起動時にDocker daemon を自動起動
[wsl2でDocker自動起動設定](https://qiita.com/ko-zi/items/949d358163bbbad5a91e)

WSL2 内にインストールした Docker は，通常と異なり docker daemon が自動起動しない．

```bash
# service docker startだけパスワード無しでsudoできるようにする
# WSL2 ターミナルにて
$ sudo visudo
# sudoersに以下を追記
ユーザ ALL=(ALL:ALL) NOPASSWD: /usr/sbin/service docker start

# .bashrcに以下を追記
$ vim ~/.bashrc
echo $(service docker status | awk '{print $4}')
if test $(service docker status | awk '{print $4}') = 'not'; then
        sudo /usr/sbin/service docker start
fi
```


## （将来を見据えて）Docker compose インストール
https://docs.docker.com/compose/install/

```bash
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```

## （任意）Docker を sudo なしで実行
https://qiita.com/DQNEO/items/da5df074c48b012152ee

```bash
$ sudo gpasswd -a $USER docker
```


## 【参考】
`\\wsl$`のアドレスにUbuntuのファイルが格納