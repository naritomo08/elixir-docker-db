#!/bin/bash
set -eu

docker compose stop

rm -rf _build deps

BUILD_CMD="docker compose build --no-cache"
CONTAINER_NAME="web postgres mariadb"

case "$OSTYPE" in
  darwin*)
    $BUILD_CMD --build-arg UID=1000 --build-arg GID=1000 $CONTAINER_NAME
    ;;
  linux*)
    HOST_UID=${SUDO_UID:-$(id -u)}
    HOST_GID=${SUDO_GID:-$(id -g)}
    $BUILD_CMD --build-arg UID="$HOST_UID" --build-arg GID="$HOST_GID" $CONTAINER_NAME
    ;;
  *)
    echo "Unknown OS Type: $OSTYPE"
    ;;
esac
