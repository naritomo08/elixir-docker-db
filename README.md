# elixir-docker-db

Docker を用いて Elixir/Phoenix アプリケーションの開発・学習を始めるための設定ファイル等のセット

## 構築される環境

* Debian 10 (Buster)
* Erlang/OTP 23
* Elixir 1.11.3
* Phoenix 1.5.7

## 必要なソフトウェア

* Docker 20 以上
* Docker Compose 1.27 以上
* Git 2.25 以上

## 動作確認済みのOS

* Windows11

## 構築方法

1. windoows11上にwsl/Ubuntu22.04をインストールする。

```bash
参考>
https://qiita.com/piacerex/items/01e89435af0f7a454ad2#elixir%E3%82%92%E6%9C%80%E6%96%B0%E7%89%882022%E5%B9%B412%E6%9C%88%E7%8F%BE%E5%9C%A8%E3%81%AF114%E3%81%AB%E4%B8%8A%E3%81%92%E3%82%8B
```

2. docker-desktopをインストールする。

従業員250人以上かつ年間売上高1000万ドル以上の企業利用の場合、
有料となるため注意

```bash
参考>
https://chigusa-web.com/blog/windows%E3%81%ABdocker%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%97%E3%81%A6python%E7%92%B0%E5%A2%83%E3%82%92%E6%A7%8B%E7%AF%89/
```

3. vscodeのインストールを行い、wsl2内のUbuntuコンソールを開く

以下のサイトを参考に、vscodeのインストール/Ubuntuコンソールを開く。

```bash
参考>
https://qiita.com/zaburo/items/27b5b819fae2bde97a3b
```

4. gitインストールを行う。

```bash
sudo apt-get install git
```

5. dockerコンテナ入手、デプロイ、立ち上げ

```bash
curl -L -o temp.zip https://github.com/naritomo08/elixir-docker-db/archive/refs/heads/main.zip
unzip temp.zip
rm temp.zip
mv elixir-docker-db-main elixir-docker-db
cd elixir-docker-db
sudo bin/setup.sh
sudo bin/start.sh
sudo bin/login.sh
```

6.Webサイト作成

```bash
mix phx.new testsite --database postgres
→yを選択する。
cd testsite
vi dev.exs
8行目を"hostname: "postgres","にする。
vi test.exs
12行目を"hostname: "postgres","にする。

```

7.DB作成

```bash
mix ecto.create
```

8.サイト立ち上げ

```bash
mix phx.server
```

9.サイト参照

ブラウザで以下のURLを参照してサイト参照できることを確認する。

```bash
http://localhost:4000
```

10.DB管理ツール(adminer)にも参照できることを確認する。

```bash
http://localhost:8080
```

