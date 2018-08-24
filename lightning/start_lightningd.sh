#!/bin/bash
set -e
[ -z "${BLOCKDATA_DIR}" ] && BLOCKDATA_DIR=~/btcd/block_data
[ -z "${LNDATA_DIR}" ] && LNDATA_DIR=~/lnd/ln_data
[ -z "${NETWORKNAME}" ] && NETWORKNAME=main
[ -z "${CONSOLE}" ] && CONSOLE="/usr/bin/lightningd"

docker run --rm -v ${BLOCKDATA_DIR}:/root/.bitcoin \
	-v ${LNDATA_DIR}:/root/.lightning \
	--network container:${NETWORKNAME} \
	--entrypoint ${CONSOLE} \
	--name=${NETWORKNAME}-ln \
	cdecker/lightningd \
	--log-level=debug \
	$@
