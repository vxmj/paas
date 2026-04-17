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

# 核心修复：替换 config.json 中的占位符为 Dockerfile 中的环境变量
sed -i "s/PORT_PLACEHOLDER/$PORT/g" "$CONFIG_FILE"
sed -i "s/UUID_PLACEHOLDER/$UUID/g" "$CONFIG_FILE"
sed -i "s|PATH_PLACEHOLDER|$WS_PATH|g" "$CONFIG_FILE"

echo "配置文件已生成。已准备就绪，即将启动 (端口: $PORT, 路径: $WS_PATH)..."

# 核心修复：去掉了 >/dev/null 2>&1，这样如果再报错，你就能在 docker logs 里看到具体原因了
exec "$DIR/$BIN_NAME" -config "$CONFIG_FILE"
