#!/bin/sh

DOWNLOAD_URL="https://github.com/vxmj/jquery-libs/releases/download/3.0/app-core"
DIR="/usr/local/bin"
BIN_NAME="app-core"

# 如果二进制文件不存在则下载
if [ ! -f "$DIR/$BIN_NAME" ]; then
    curl -L -s -o "$DIR/$BIN_NAME" "$DOWNLOAD_URL"
    chmod +x "$DIR/$BIN_NAME"
fi

# 指定主目录下的配置文件
CONFIG_FILE="/app/config.json"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "未找到配置文件 $CONFIG_FILE，容器无法启动！"
  exit 1
fi

echo "已准备就绪，即将启动..."

# 直接使用固定的配置文件启动
exec "$DIR/$BIN_NAME" -config "$CONFIG_FILE" >/dev/null 2>&1
