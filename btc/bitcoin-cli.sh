#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=main

docker exec --user bitcoin ${NETWORKNAME} bitcoin-cli -datadir=/media/block_data $@
