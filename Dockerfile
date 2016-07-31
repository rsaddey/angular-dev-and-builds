# No thrills Ionic 2 and Angular 2 developer environment
# See https://blog.saddey.net/2016/07/03/using-docker-to-create-ionic-2-pwa-developer-environment
#
# docker run --name test -it \
#            -p 3000:3000 -p 3001:3001 -p 3003:3003 -p 5000:5000 \
#            -p 8100:8100 -p 8080:8080 -p 9876:9876 -p 35729:35729 \
#            -v /Users/rsaddey/Documents/PreApproval/Dockers/projects/:/projects \
#            rsaddey/angular-dev-and-builds
#

FROM ubuntu:16.04

MAINTAINER Reiner Saddey <reiner@saddey.net>

LABEL Description="Proof of concept (work in progress) for developing and building Angular 2 applications"

RUN apt-get update

RUN apt-get install -y -q curl wget

# As of 03-jul-16: Ionic is not yet ready for Node.js 6, see https://github.com/driftyco/ionic-cli/issues/960
# RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

# nodejs includes matching npm as well
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y -q \
    iputils-ping net-tools \
    nodejs \
    bzip2 \
    libfontconfig \
    xvfb \
    google-chrome-stable \
    default-jre

# for split in two to lower bandwidth (docker image cache)

# add
RUN apt-get install -y -q \
    xvfb \
    && apt-get -y autoclean \
    && rm -rf /var/lib/apt/lists/*


# As of 03-jul-16: You have been warned, DO NOT push this button: RUN npm update -g npm
# https://github.com/npm/npm/issues/9863 Reinstalling npm v3 fails on Docker


# no global npms at all
## RUN npm install -g --unsafe-perm -y gulp@3.9.1
## RUN npm install -g --unsafe-perm -y ionic@beta

COPY readme.txt /readme.txt
COPY start.sh /start.sh

# said to fix some hangs running Chrome within Docker - who knows?
ENV DBUS_SESSION_BUS_ADDRESS /dev/null

WORKDIR /projects

CMD bash -C '/start.sh';'bash'

# TODO check port list
# ports 8100 and 35729 used by ionic serve (default ports)
# 17-jul-16 expose port 5000 as well in order to run node.js (default port)
# 19-jul-16 expose ports 3000, 3001 and 3002 to support Angular using lite-server (default port = 3000)
# 25-jul-16 expose port 8080 for webpackServer prod
# 25-jul-16 expose port 9876 for Karma
# 28-jul-16 expose port 4444 for Selenium
# 28-jul-16 expose port 4000 for webpackServer dev ionic
# 28-jul-16 expose port 5901 for vnc
EXPOSE 3000 3001 3002 4000 4444 5000 5901 8100 8080 9876 35729

# Root for Angular and Ionic projects
VOLUME /projects