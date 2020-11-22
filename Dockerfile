# base image
FROM nvidia/cuda:10.2-runtime-ubuntu16.04

# create new USER
ENV DEBIAN_FRONTEND noninteractive
ENV USER ubuntu
ENV HOME /home/ubuntu

RUN adduser ubuntu --disabled-password

# update
RUN apt-get update && apt-get install -y --no-install-recommends \
        locales \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

# unity
RUN apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        gnome-terminal \
        metacity \
        nautilus \
        gedit \
        sudo

# dependency
RUN apt-get install -y --no-install-recommends \
        supervisor \
        net-tools \
        git \
        pwgen

# clear
RUN apt-get autoclean \
        && apt-get autoremove \
            && rm -rf /var/lib/apt/lists/*

# tigerVNC
ADD https://dl.bintray.com/tigervnc/stable/tigervnc-1.9.0.x86_64.tar.gz $HOME/tigervnc/tigervnc.tar.gz
RUN tar xmzf $HOME/tigervnc/tigervnc.tar.gz -C $HOME/tigervnc/ && rm $HOME/tigervnc/tigervnc.tar.gz
RUN cp -R $HOME/tigervnc/tigervnc-1.9.0.x86_64/* / && rm -rf $HOME/tigervnc/

# noVNC
RUN git clone https://github.com/novnc/noVNC.git $HOME/noVNC
RUN cp $HOME/noVNC/vnc.html $HOME/noVNC/index.html

# Websockify for noVNC
RUN git clone https://github.com/novnc/websockify.git $HOME/noVNC/utils/websockify

# Copy supervisor config
COPY config/supervisor.conf /etc/supervisor/conf.d/

# Set xsession config
COPY config/xsession $HOME/.xsession

# Set startup script
COPY config/startup.sh $HOME

# expose
EXPOSE 6080

# run
CMD [ "/bin/bash", "/home/ubuntu/startup.sh" ]