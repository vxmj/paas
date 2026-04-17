FROM alpine:latest

# 仅保留基础运行和下载所需的依赖
RUN apk add --no-cache ca-certificates curl

# 设置 /app 为主目录
WORKDIR /app

# 将写好的 config.json 复制到主目录
COPY config.json /app/config.json
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
