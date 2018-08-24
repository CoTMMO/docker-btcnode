#!/bin/bash
[ -z "${BLOCKDATA_DIR}" ] && BLOCKDATA_DIR=~/btcd/block_data
[ -z "${NETWORKNAME}" ] && NETWORKNAME=bitcore-node-v8
[ -z "${API_PORT}" ] && API_PORT=3001
# Don't support parameters in ${CONSOLE}
[ "${CONSOLE}" ] && ENTRY="--entrypoint ${CONSOLE}"

if [ "${CONSOLE}" ]; then
    docker run --env BITCOIN_DATA=/media/block_data -v ${BLOCKDATA_DIR}:/media/block_data --name=${NETWORKNAME} ${ENTRY} -p ${API_PORT}:3000 --rm -it docker-bitcore
else
    docker run --env BITCOIN_DATA=/media/block_data -v ${BLOCKDATA_DIR}:/media/block_data --name=${NETWORKNAME} -p ${API_PORT}:3000 --rm -it docker-bitcore $@
fi
