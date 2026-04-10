# Arch Linux noVNC VM

A minimal GitHub repo for running an Arch Linux container with a desktop session exposed through noVNC.

## What this provides

- Arch Linux base image
- `Xvfb` virtual framebuffer
- `KDE Plasma` desktop environment
- Multiple terminal emulators: `konsole`, `kitty`, `gnome-terminal`, `xfce4-terminal`, `alacritty`, `tilix`, `terminator`
- Common utilities: `neovim`, `vim`, `nano`, `htop`, `curl`, `wget`, `tree`, `man-db`, `man-pages`, `base-devel`- Web browser: `firefox`- `x11vnc` VNC server
- `noVNC` web client on port `6080`

## Run locally

Build and start with Docker Compose:

```bash
docker compose up --build
```

Then open your browser at:

- `http://localhost:6080/vnc.html`

## Access via VNC client

You can also connect a VNC client to port `5900`.

## Launch KDE apps and terminals

After the container is running, use the helper script to open KDE Plasma apps and terminals in the running session:

```bash
docker compose exec arch-vm launch-kde-apps.sh
```

That script will start available terminal emulators and key KDE utilities like `dolphin` and `systemsettings`.

## Notes

- The container runs as `root` so you have full privileges inside the session.
- This is not a full VM, but a containerized desktop environment that behaves like an Arch Linux session.
- For a more complete environment, install additional Arch packages inside the container.

Usage
After starting the container:

docker compose exec arch-vm launch-kde-apps.sh
