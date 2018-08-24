#!/bin/bash
[ -z "${NETWORKNAME}" ] && NETWORKNAME=main

docker logs ${NETWORKNAME} $@
