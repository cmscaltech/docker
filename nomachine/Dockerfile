FROM ubuntu:kinetic
# Notes:
#
# Modifications:
# - 2023-Feb-27: Move to Ubuntu 22.04
# - 2023-Feb-27: Install Latest NoMachine 8.4.2_1
# - 2023-Feb-27: Install JRE/JDK and icedtea packages.
# - 2023-Feb-27: Install Chromium browser

ENV DEBIAN_FRONTEND=noninteractive

# Configure timezone and locale to spanish and America/Bogota timezone. Change locale and timezone to whatever you want
ENV LANG="en_US.UTF-8"
ENV LANGUAGE=en_US

# Goto https://www.nomachine.com/download/download&id=10 and change for the latest NOMACHINE_PACKAGE_NAME and MD5 shown in that link to get the latest version.
ENV NOMACHINE_PACKAGE_NAME nomachine_8.4.2_1_amd64.deb
ENV NOMACHINE_BUILD 8.4
ENV NOMACHINE_MD5 35d9c2af67707a9e7cd764e3aeda4624

RUN apt-get clean && apt-get update && apt-get install -y locales && \
    locale-gen en_US.UTF-8 && locale-gen en_US && \
    echo "America/New_York" > /etc/timezone && \
    apt-get install -y locales && \
    sed -i -e "s/# $LANG.*/$LANG.UTF-8 UTF-8/" /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=$LANG && \
    apt-get update -y && \
    apt-get install -y software-properties-common sudo && \
    add-apt-repository universe && \
    apt-get update -y && \
    apt-get install -y xterm pulseaudio cups curl \
    iputils-ping libxss1 wget xdg-utils libpango1.0-0 fonts-liberation \
    mate-desktop-environment-extras htop nano git vim && \
    apt-get install -y default-jre default-jdk icedtea-netx && \
    curl -fSL "http://download.nomachine.com/download/${NOMACHINE_BUILD}/Linux/${NOMACHINE_PACKAGE_NAME}" -o nomachine.deb \
    && echo "${NOMACHINE_MD5} *nomachine.deb" | md5sum -c - && dpkg -i nomachine.deb && sed -i "s|#EnableClipboard both|EnableClipboard both |g" /usr/NX/etc/server.cfg

RUN cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && apt install -y ./google-chrome-stable_current_amd64.deb

ADD build/nxserver.sh /

ENTRYPOINT ["/nxserver.sh"]
