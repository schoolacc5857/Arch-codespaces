#!/bin/bash
set -e

DISPLAY=${DISPLAY:-:1}
export DISPLAY

if ! pgrep -f "Xvfb :1" >/dev/null 2>&1; then
  echo "Error: Xvfb is not running on DISPLAY $DISPLAY"
  exit 1
fi

apps=()
for cmd in konsole alacritty gnome-terminal xfce4-terminal terminator dolphin systemsettings firefox ; do
  if command -v "$cmd" >/dev/null 2>&1; then
    apps+=("$cmd")
  fi
done

if [ ${#apps[@]} -eq 0 ]; then
  echo "No supported KDE apps or terminal emulators are installed."
  exit 1
fi

for app in "${apps[@]}"; do
  nohup "$app" >/dev/null 2>&1 &
done

echo "Launched: ${apps[*]}"
