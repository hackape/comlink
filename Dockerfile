FROM selenium/node-chrome:latest@sha256:4e13b7ef01752811fde871f78c19bae8f3bdb77352997fd762c9462d9a3f8c04

USER root

RUN apt-get update -qqy \
  && apt-get -qqy install nodejs npm \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
  && rm /bin/sh && ln -s /bin/bash /bin/sh \
  && chown seluser /usr/local

ENV NVM_DIR /usr/local/nvm
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash \
  && source $NVM_DIR/nvm.sh \
  && nvm install v8

ENV CHROME_BIN /opt/google/chrome/chrome
ENV INSIDE_DOCKER=1

WORKDIR /usr/src
ENTRYPOINT source $NVM_DIR/nvm.sh && npm i && npm test
