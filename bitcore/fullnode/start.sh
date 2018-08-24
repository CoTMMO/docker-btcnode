#!/bin/bash
set -e

BITCORE_CONFIG_PATH=./bitcore/config
BITCORE_BIN_PATH=./bitcore/node_modules/bitcore/bin

start_mainnet() {
    cp ${BITCORE_CONFIG_PATH}/mainnet.json bitcore-node.json
    ${BITCORE_BIN_PATH}/bitcore start
}

start_testnet() {
    cp ${BITCORE_CONFIG_PATH}/testnet.json bitcore-node.json
    ${BITCORE_BIN_PATH}/bitcore start
}

start_regtest() {
    cp ${BITCORE_CONFIG_PATH}/regtest.json bitcore-node.json
    ${BITCORE_BIN_PATH}/bitcore start
}

[ -z $1 ] && start_mainnet
[ "$1" == "-testnet" ] && start_testnet
[ "$1" == "-regtest" ] && start_regtest
