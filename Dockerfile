FROM alpine:3.20

RUN apk add --no-cache \
    bash \
    curl \
    tzdata \
    git \
    build-base \
    linux-headers \
    openssl-dev \
    zlib-dev

WORKDIR /opt/mtproto

RUN git clone https://github.com/TelegramMessenger/MTProxy.git .

RUN make

RUN curl -fsSL https://core.telegram.org/getProxySecret -o proxy-secret \
    && curl -fsSL https://core.telegram.org/getProxyConfig -o proxy-multi.conf

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV PORT=443
ENV SECRET=c4a9f2d8b7e31a6c9d4f8b2e7a1c5d09
ENV WORKERS=1

EXPOSE 443

CMD ["/start.sh"]
