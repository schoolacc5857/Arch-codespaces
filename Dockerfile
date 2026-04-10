FROM archlinux:latest

RUN cat > /etc/pacman.d/mirrorlist <<'EOF'
Server = https://mirror.rackspace.com/archlinux/$repo/os/$arch
Server = https://mirror.math.princeton.edu/pub/archlinux/$repo/os/$arch
Server = https://archlinux.mirror.constant.com/$repo/os/$arch
EOF

RUN pacman -Syu --noconfirm \
    sudo xorg-server-xvfb xorg-xauth xorg-fonts-misc xterm openbox x11vnc git python python-pip wget unzip \
    inetutils python-pyxdg python-numpy plasma \
    && pacman -Scc --noconfirm

RUN git clone --depth 1 https://github.com/novnc/noVNC /opt/noVNC \
    && git clone --depth 1 https://github.com/novnc/websockify /opt/noVNC/utils/websockify

RUN useradd -m archuser \
    && echo "archuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/archuser

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 6080 5900
USER archuser
WORKDIR /home/archuser
CMD ["/usr/local/bin/start.sh"]
