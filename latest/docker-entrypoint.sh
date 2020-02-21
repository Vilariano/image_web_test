#!/bin/bash

# set -e
# SCREEN="${SCREEN:-1280x1024x16}"
# echo "Starting X virtual framebuffer (Xvfb) for $SCREEN screen in background..."
# Xvfb -ac :99 -screen 0 $SCREEN > /dev/null 2>&1 &
# export DISPLAY=:99

# exec "$@"

echo "http://dl-4.alpinelinux.org/alpine/v3.9/main/" >> /etc/apk/repositories && \
echo "http://dl-4.alpinelinux.org/alpine/v3.9/community/" >> /etc/apk/repositories


apk update && \
  apk add build-base \
  libxml2-dev \
  libxslt-dev \
  curl unzip libexif udev chromium chromium-chromedriver wait4ports xvfb xorg-server dbus ttf-freefont mesa-dri-swrast \
  && rm -rf /var/cache/apk/*