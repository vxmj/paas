FROM alpine:latest

RUN apk add --no-cache ca-certificates curl sed

ENV PORT=30022
ENV UUID=209563cc-ea0a-4676-adb0-c8e79ca4db75
ENV WS_PATH=/api/v2/icons/2f9bc001

WORKDIR /app

COPY config.json /app/config.json
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
