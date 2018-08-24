#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=main

docker exec --user node -ti ${NETWORKNAME} bash
