# Docker image for bitcore
FROM node:carbon-stretch
LABEL maintainer="qinfengling <fengling.qin@gmail.com>"

ARG DEFAULT_UID=1000
ARG DEFAULT_GID=1000
ARG SSH_PRIVATE_KEY

RUN echo "Container with UID:${DEFAULT_UID} and GID:${DEFAULT_GID}"
RUN usermod -u ${DEFAULT_UID} node
RUN groupmod -g ${DEFAULT_GID} node

RUN apt-get update && \
    apt-get install -y vim libzmq3-dev build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Fix the permission of block_data
RUN mkdir /media/block_data && \
    chown ${DEFAULT_UID}:${DEFAULT_GID} /media/block_data

USER node
# Prepare ssh key for private repo
RUN mkdir -p /home/node/.ssh/
RUN echo "${SSH_PRIVATE_KEY}" > /home/node/.ssh/id_rsa
RUN chmod 0400 /home/node/.ssh/id_rsa
RUN ssh-keyscan -H github.com >> /home/node/.ssh/known_hosts

RUN mkdir -p /home/node/fullnode
COPY --chown=node:node ./fullnode /home/node/fullnode
WORKDIR /home/node/fullnode

RUN cd bitcore && \
    npm install && \
    patch -p2 < patch/0001-Fix-_getHash-when-use-block-height.patch && \
    cd node_modules/insight-ui/app && \
    npm run build
RUN rm /home/node/.ssh/id_rsa

ENTRYPOINT ["./start.sh"]

EXPOSE 3001
