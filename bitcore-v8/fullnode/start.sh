#!/bin/bash
PID_MONGOD=`pidof mongod`
[ "${PID_MONGOD}" == "" ] && mongod --fork --dbpath /media/block_data/ --logpath /media/block_data/mongod.log

BITCORE_BIN_PATH=./node_modules/bitcore-node/bin
${BITCORE_BIN_PATH}/start
