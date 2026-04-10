FROM archlinux:latest

RUN cat > /etc/pacman.d/mirrorlist <<'EOF'
Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch
Server = https://mirror.math.princeton.edu/pub/archlinux/$repo/os/$arch
Server = https://mirror.rcn-ee.com/archlinux/$repo/os/$arch
Server = https://mirror.umd.edu/archlinux/$repo/os/$arch
EOF

RUN pacman -Syu --disable-download-timeout --noconfirm \
    sudo xorg-server-xvfb xorg-xauth xorg-fonts-misc xterm openbox x11vnc git python python-pip wget unzip \
    inetutils python-pyxdg python-numpy plasma \
    konsole kitty gnome-terminal xfce4-terminal alacritty terminator \
    neovim vim nano htop curl tree file man-db man-pages base-devel \
    networkmanager polkit ksshaskpass firefox \
    && pacman -Scc --noconfirm

RUN git clone --depth 1 https://github.com/novnc/noVNC /opt/noVNC \
    && git clone --depth 1 https://github.com/novnc/websockify /opt/noVNC/utils/websockify

COPY launch-kde-apps.sh /usr/local/bin/launch-kde-apps.sh
RUN chmod +x /usr/local/bin/launch-kde-apps.sh

RUN useradd -m archuser \
    && echo "archuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/archuser

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

EXPOSE 6080 5900
USER root
WORKDIR /home/archuser
CMD ["/usr/local/bin/start.sh"]
