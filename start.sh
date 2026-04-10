#!/bin/bash
set -e

export DISPLAY=:1

Xvfb :1 -screen 0 1280x800x24 &
XVFB_PID=$!

sleep 2

startplasma-x11 &
PLASMA_PID=$!

x11vnc -display :1 -forever -nopw -shared -rfbport 5900 &

exec /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6080 --web /opt/noVNC
