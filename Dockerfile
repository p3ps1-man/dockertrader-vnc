FROM p3ps1man/dockertrader:latest

ENV VNC_PORT=5901 \
    RESOLUTION=1920x1080 \
    WEB_PORT=3000 \
    SUPERVISORD_PIDFILE=/home/mt5/.supervisor/supervisord.pid \
    SUPERVISORD_LOGFILE=/home/mt5/.supervisor/supervisord.log \
    CERT=/home/mt5/ssl/cert.pem \
    KEY=/home/mt5/ssl/key.pem \
    VNC_PASSWORD=changeme

USER root

RUN pacman -Sy --noconfirm \
    x11vnc \
    supervisor \
    git \
    openssl

RUN git clone https://github.com/novnc/noVNC.git /usr/share/novnc && \
    git clone https://github.com/novnc/websockify.git /usr/share/novnc/utils/websockify

USER mt5
WORKDIR /home/mt5

RUN mkdir .supervisor && mkdir ssl
RUN openssl req -x509 -newkey rsa:4096 -keyout ssl/key.pem -out ssl/cert.pem -days 36500 -nodes -subj "/"

COPY supervisord.conf .supervisor/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", ".supervisor/supervisord.conf"]