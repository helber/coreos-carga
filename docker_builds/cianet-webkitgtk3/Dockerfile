FROM ubuntu:16.04
MAINTAINER Helber Maciel Guerra <helber@cianet.ind.br>

USER root

# VNC
RUN apt-get update -qqy \
  && apt-get -qqy install x11vnc \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p ~/.vnc \
  && x11vnc -storepasswd 123 ~/.vnc/passwd

# Locale settings
ENV TZ="America/Sao_Paulo"
ENV SCREEN_WIDTH=1280
ENV SCREEN_HEIGHT=800
ENV SCREEN_DEPTH=24
ENV DISPLAY=":99.0"
ENV LANGUAGE pt_BR.UTF-8
ENV LANG pt_BR.UTF-8
RUN locale-gen pt_BR.UTF-8 \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install language-pack-en \
  && rm -rf /var/lib/apt/lists/*

# Fonts
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    fonts-ipafont-gothic \
    xfonts-100dpi \
    xfonts-75dpi \
    xfonts-cyrillic \
    xfonts-scalable \
  && rm -rf /var/lib/apt/lists/*

# libwebkit2gtk-3.0-25 | libwebkit2gtk-4.0-37
# fluxbox & libwebkit2gtk
RUN apt-get update -qqy \
  && apt-get -qqy install fluxbox \
  && apt-get -qqy install libwebkit2gtk-4.0-37 \
  && rm -rf /var/lib/apt/lists/*

# IPTV ENV
ENV IPTV_SERIAL=123456
ENV IPTV_MAC="FF:FF:FF:00:00:00"
ENV IPTV_HOST="middleware.iptvdomain"
ENV IPTV_PATH="debug/?profile_test=guide_programmes#repg"
ENV IPTV_DISABLE_CACHE=false

RUN apt-get update -qqy \
  && apt-get -qqy install sudo \
  && rm -rf /var/lib/apt/lists/*

RUN useradd seluser --shell /bin/bash --create-home \
  && usermod -a -G sudo seluser \
  && echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  && echo 'seluser:secret' | chpasswd

COPY entry_point.sh /opt/bin/entry_point.sh
COPY start_rx.sh /opt/bin/start_rx.sh
COPY stop_rx.sh /opt/bin/stop_rx.sh
RUN chmod +x /opt/bin/entry_point.sh /opt/bin/start_rx.sh /opt/bin/stop_rx.sh

RUN apt-get update -qqy \
  && apt-get -qqy install xvfb \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 5900
