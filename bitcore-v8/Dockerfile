# Docker image for Bitcore Node v8.0.0
FROM node:carbon
LABEL maintainer="qinfengling <fengling.qin@gmail.com>"

ARG DEFAULT_UID=1000
ARG DEFAULT_GID=1000
ARG SSH_PRIVATE_KEY

RUN echo "Container with UID:${DEFAULT_UID} and GID:${DEFAULT_GID}"
RUN usermod -u ${DEFAULT_UID} node
RUN groupmod -g ${DEFAULT_GID} node

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5 && \
    echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list && \
    apt-get update && \
    apt-get install -y vim libzmq3-dev build-essential mongodb-org && \
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

RUN npm install bitcore-node@beta
RUN rm /home/node/.ssh/id_rsa

ENTRYPOINT ["./start.sh"]

EXPOSE 3001
