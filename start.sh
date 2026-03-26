#!/bin/sh
set -e

mkdir -p /data

if [ ! -f /data/secret ]; then
  if [ "$SECRET" = "00000000000000000000000000000000" ]; then
    SECRET="$(head -c 16 /dev/urandom | xxd -ps)"
  fi
  echo "$SECRET" > /data/secret
else
  SECRET="$(cat /data/secret)"
fi

exec /opt/mtproto/objs/bin/mtproto-proxy \
  -u nobody \
  -p 8888 \
  -H "$PORT" \
  -S "$SECRET" \
  -M "$WORKERS" \
  $( [ -n "$TAG" ] && echo "-P $TAG" ) \
  --aes-pwd /opt/mtproto/proxy-secret /opt/mtproto/proxy-multi.conf \
  --http-stats \
  --nat-info 0.0.0.0:0
