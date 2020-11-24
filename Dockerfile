# argument
ARG IMAGE

# base image
FROM $IMAGE

# maintainer
LABEL maintainer "SDANUTHA <s.danutha@gmail.com>"

# create new USER
ENV DEBIAN_FRONTEND noninteractive

ENV USER ubuntu
ENV HOME /home/ubuntu

RUN adduser ubuntu --disabled-password

# unity and dependency
RUN apt-get update \
        && apt-get install -y --no-install-recommends \
            locales \
            ubuntu-desktop \
            gnome-panel \
            gnome-terminal \
            metacity \
            nautilus \
            sudo \
            supervisor \
            net-tools \
            git \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# environment
ENV LANG en_US.utf8

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

# run
CMD [ "/bin/bash", "/home/ubuntu/startup.sh" ]
