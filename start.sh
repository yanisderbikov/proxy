#!/bin/sh
set -e

if [ "$SECRET" = "00000000000000000000000000000000" ]; then
  SECRET=$(head -c 16 /dev/urandom | xxd -ps)
fi

exec /opt/mtproto/objs/bin/mtproto-proxy \
  -u nobody \
  -p 8888 \
  -H "$PORT" \
  -S "$SECRET" \
  --aes-pwd proxy-secret proxy-multi.conf
