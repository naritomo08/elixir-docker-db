# elixir-docker-db

Docker を用いて Elixir/Phoenix アプリケーションの開発・学習を始めるための設定ファイル等のセット

## 構築される環境

* Erlang/OTP 24
* Elixir 1.13.4
* Phoenix 1.6.15

## 必要なソフトウェア

* Docker 20 以上
* Docker Compose 1.27 以上

## 動作確認済みのOS

* Windows11

## 構築方法

### windoows11上にwsl/Ubuntu22.04をインストールする。

参考>
[Ubuntu 22.04でElixirの最短手順](https://qiita.com/piacerex/items/01e89435af0f7a454ad2)

作業実施後、以下のコマンドをwindowsコマンドプロンプトで実施する。

```bash
wsl --unregister Ubuntu
wsl --set-default Ubuntu-22.04
wsl --list --verbose
```

### docker-desktopをインストールする。

従業員250人以上かつ年間売上高1000万ドル以上の企業利用の場合、
有料となるため注意

参考>
[Docker Desktop インストール手順](https://qiita.com/R_R/items/a09fab09ce9fa9e905c5)

Docker Desktopを使用しない(できない)場合、以下のサイトを参照

[DockerDesktopからWSL2上のみで動くDockerに移行する](https://zenn.dev/taiga533/articles/11f1b21ef4a5ff)

### vscodeのインストールを行い、wsl2内のUbuntuコンソールを開く

以下のサイトを参考に、vscodeのインストール/Ubuntuコンソールを開く。

参考>
[WSL2 + Ubuntu + VSCodeでの開発環境構築](https://qiita.com/zaburo/items/27b5b819fae2bde97a3b)

### dockerコンテナ入手、デプロイ、立ち上げ

```bash
git clone -b phx1.6 https://github.com/naritomo08/elixir-docker-db.git elixir-docker-db
cd elixir-docker-db
sudo bin/setup.sh
sudo bin/start.sh
sudo bin/login.sh
```

### Webサイト作成

```bash
mix phx.new testsite --database postgres
→yを選択する。
cd testsite
vi config/dev.exs
8行目を"hostname: "postgres","にする。
22行目を"http: [ip: {0, 0, 0, 0}, port: 4000],"にする。
vi config/test.exs
12行目を"hostname: "postgres","にする。
19行目を"http: [ip: {0, 0, 0, 0}, port: 4002],"にする。
```

### DB作成

```bash
mix ecto.create
```

### サイト立ち上げ

```bash
mix phx.server
```

### サイト参照

ブラウザで以下のURLを参照してサイト参照できることを確認する。

http://localhost:4000

### DB管理ツール(adminer)にも参照できることを確認する。

http://localhost:8081

* ログイン情報(postgresql)
  - データベース種類: Postgresql
  - サーバ: postgres
  - ユーザ名: postgres
  - パスワード:postgres
  
* ログイン情報(mariadb)
  - データベース種類: mysql
  - サーバ: mariadb
  - ユーザ名: root
  - パスワード:root

### コンテナ停止

```bash
Ctrl+c を2回
exit
sudo bin/stop.sh
```
