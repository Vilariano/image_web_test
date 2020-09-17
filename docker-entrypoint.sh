#!/bin/bash

set -e
echo "Starting X virtual framebuffer (Xvfb) in background..."
Xvfb -ac :99 -screen 0 1920x1024x16 > /dev/null 2>&1 &
export DISPLAY=:99

exec "$@"
