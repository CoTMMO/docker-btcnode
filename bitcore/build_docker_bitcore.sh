#!/bin/bash
MYUID=`id -u`
MYGID=`id -g`
[ -z "${PRIVATE_KEY}" ] && PRIVATE_KEY=`cat ${HOME}/.ssh/id_rsa` && SQUASH_OPT="--squash"
[ -z "${IMAGE_NAME}" ] && IMAGE_NAME=docker-bitcore

docker build ${SQUASH_OPT} --build-arg SSH_PRIVATE_KEY="${PRIVATE_KEY}" --build-arg DEFAULT_UID=${MYUID} --build-arg DEFAULT_GID=${MYGID} -t ${IMAGE_NAME} .
