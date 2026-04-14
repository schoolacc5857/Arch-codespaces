#!/bin/bash
set -e
set -o pipefail

export DISPLAY=:1
export XDG_RUNTIME_DIR=/run/user/0
mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR"

# Clean up any stale X lock or socket files from a previous run.
rm -f /tmp/.X1-lock /tmp/.X11-unix/X1

Xvfb :1 -screen 0 1280x800x24 -ac &
XVFB_PID=$!

for i in $(seq 1 15); do
  xdpyinfo -display :1 >/dev/null 2>&1 && break
  sleep 1
 done

pkill -f openbox || true
pkill -f startplasma-x11 || true

# Start Plasma in a dedicated dbus session so KDE services can launch.
dbus-run-session -- bash -lc '
  export DISPLAY=:1
  export XDG_RUNTIME_DIR=/run/user/0
  exec startplasma-x11 >/tmp/plasma-start.log 2>&1
' &
PLASMA_PID=$!

# Wait for the X server to be ready before launching x11vnc.
for i in $(seq 1 15); do
  xdpyinfo -display :1 >/dev/null 2>&1 && break
  sleep 1
 done

# Wait for Plasma to start up before starting x11vnc
for i in $(seq 1 30); do
  pgrep -f plasmashell >/dev/null 2>&1 && break
  sleep 1
 done

x11vnc -display :1 -forever -nopw -shared -rfbport 5900 &

exec /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6080 --web /opt/noVNC
