#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=mainnet
docker exec -ti ${NETWORKNAME}-ln bash
