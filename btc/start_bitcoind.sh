#!/bin/bash
[ -z "${BLOCKDATA_DIR}" ] && BLOCKDATA_DIR=~/btcd/block_data
[ -z "${NETWORKNAME}" ] && NETWORKNAME=main
# Don't support parameters in ${CONSOLE}
[ "${CONSOLE}" ] && ENTRY="--entrypoint ${CONSOLE}"

# $1 must be the network mode if it run as fullnode
[ "$1" != "-testnet" -a "$1" != "-regtest" ] && PORTS="-p 8332:8332 -p 8333:8333"
[ "$1" == "-testnet" ] && PORTS="-p 18332:18332 -p 18333:18333"
# bitcond regtest network RPC port NOTE:
# 18332 (version <= 0.15), 18443 (version >= 0.16)
[ "$1" == "-regtest" ] && PORTS="-p 18443:18443 -p 18444:18444"

[ "${LN_ENABLE}" == "1" ] && PORTS+=" -p 9735:9735"

if [ "${CONSOLE}" ]; then
    docker run --env BITCOIN_DATA=/media/block_data -v ${BLOCKDATA_DIR}:/media/block_data ${PORTS} --name=${NETWORKNAME} ${ENTRY} --rm -it ruimarinho/bitcoin-core
else
    docker run --env BITCOIN_DATA=/media/block_data -v ${BLOCKDATA_DIR}:/media/block_data ${PORTS} --name=${NETWORKNAME} --rm -it ruimarinho/bitcoin-core \
	-printtoconsole \
	-deprecatedrpc=estimatefee \
	$@
fi
