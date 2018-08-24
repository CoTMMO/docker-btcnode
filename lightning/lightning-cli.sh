#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=mainnet
docker exec ${NETWORKNAME}-ln lightning-cli $@
