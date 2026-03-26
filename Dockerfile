FROM alpine:3.20

RUN apk add --no-cache bash curl tzdata

RUN mkdir -p /opt/mtproto /data
WORKDIR /opt/mtproto

RUN curl -L -o mtproto-proxy.tar.gz https://github.com/TelegramMessenger/MTProxy/archive/refs/heads/master.tar.gz \
    && tar -xzf mtproto-proxy.tar.gz --strip-components=1 \
    && rm mtproto-proxy.tar.gz

RUN apk add --no-cache alpine-sdk linux-headers openssl-dev zlib-dev make git \
    && make -C objs \
    && apk del alpine-sdk linux-headers openssl-dev zlib-dev make git

RUN curl -L -o /opt/mtproto/proxy-secret https://core.telegram.org/getProxySecret \
    && curl -L -o /opt/mtproto/proxy-multi.conf https://core.telegram.org/getProxyConfig

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV PORT=443
ENV SECRET=00000000000000000000000000000000
ENV TAG=
ENV WORKERS=1

EXPOSE 443

CMD ["/start.sh"]
