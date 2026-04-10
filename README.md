# Arch Linux noVNC VM

A minimal GitHub repo for running an Arch Linux container with a desktop session exposed through noVNC.

## What this provides

- Arch Linux base image
- `Xvfb` virtual framebuffer
- `KDE Plasma` desktop environment
- `x11vnc` VNC server
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

## Notes

- The container runs as an unprivileged user `archuser`.
- This is not a full VM, but a containerized desktop environment that behaves like an Arch Linux session.
- For a more complete environment, install additional Arch packages inside the container.

## License

MIT
