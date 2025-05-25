FROM elixir:1.11.4-alpine

# 環境変数
ENV MIX_ENV=dev
ENV LANG=C.UTF-8

# パッケージインストール（build tools + PostgreSQL client + nodejs）
RUN apk update && apk add --no-cache \
  bash \
  git \
  curl \
  build-base \
  postgresql-client \
  nodejs \
  npm \
  inotify-tools \
  mariadb-client \
  sudo

# Hex & Rebar（Elixirビルドツール）のインストール
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.5.8

# ユーザー作成（任意）
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID devel && \
    adduser -D -u $UID -G devel devel && \
    echo "devel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER devel
WORKDIR /home/devel

# Phoenixプロジェクトのコードをコピーする場合
# COPY --chown=devel:devel ./apps /apps

# 必要ならエイリアスも追加
RUN echo "alias elixirc='elixirc --ignore-module-conflict'" >> ~/.bashrc
