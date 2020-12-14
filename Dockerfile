FROM archlinux:latest

MAINTAINER Jon Packard <jon@packard.tech>

RUN pacman --noconfirm --needed -Syu youtube-dl ffmpeg rtmpdump atomicparsley python-pycryptodome \
    && rm -rf /var/cache/pacman/pkg/*

COPY entrypoint.sh /entrypoint.sh
RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
