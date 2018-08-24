#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=main

docker exec --user bitcoin -ti ${NETWORKNAME} bash
