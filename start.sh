#!/bin/sh
set -eu

if [ -z "${PORT:-}" ]; then
  PORT=443
fi

if [ -z "${SECRET:-}" ]; then
  SECRET=c4a9f2d8b7e31a6c9d4f8b2e7a1c5d09
fi

if [ -z "${WORKERS:-}" ]; then
  WORKERS=1
fi

exec /opt/mtproto/objs/bin/mtproto-proxy \
  -u nobody \
  -p 8888 \
  -H "$PORT" \
  -S "$SECRET" \
  -M "$WORKERS" \
  --aes-pwd /opt/mtproto/proxy-secret /opt/mtproto/proxy-multi.conf
