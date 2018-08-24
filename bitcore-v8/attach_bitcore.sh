#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=bitcore-node-v8

docker exec --user node -ti ${NETWORKNAME} bash
