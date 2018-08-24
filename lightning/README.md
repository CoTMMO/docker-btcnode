# Lightning node in Docker

## Requirement
Lightningd needs rpc connections to a bitcoind node to run.
For security reasons, rpc ports should not be published.
Therefore, the docker containers of lightningd and bitcoind need to run on the same server
with lightningd container attached to the network of bitcoind container for rpc access
and the docker container of bitcoind should have the port 9735 opened.

## Environment Variables
* `BLOCKDATA_DIR`: directory for data of bitcoind.
* `LNDATA_DIR`: directory for data of lightningd.
* `NETWORKNAME`: name of bitcoind container. Lightningd container's name is automatically set to `${NETWORKNAME}-ln`.
* `CONSOLE`: override the entrypoint. E.g. CONSOLE=bash, it will start bash instead of bitcoind/lightningd.

## Files
* `install_lightningd.sh`:  Install the latest lightningd docker image
* `start_lightningd.sh`: Start lightning fullnode with parameters
* `lightning-cli.sh`: Lightning cli wrapper for different fullnode mode
* `attach-lightningd.sh`: Attach to lightningd docker's shell

## Guide

### Install the docker file
```bash
./install_lightningd.sh
```

### Start lightning node
There are 3 running modes.

#### mainnet:

```bash
DATA_DIR=~/btcd/mainnet_data
mkdir -p ${DATA_DIR}
LN_ENABLE=1 BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=mainnet ./start_bitcoind.sh
LN_DIR=~/lnd/mainnet_data
mkdir -p ${LN_DIR}
BLOCKDATA_DIR=${DATA_DIR} LNDATA_DIR=${LN_DIR} NETWORKNAME=mainnet ./start_lightningd.sh --network=bitcoin
```

#### testnet:

```bash
DATA_DIR=~/btcd/testnet3_data
mkdir -p ${DATA_DIR}
LN_ENABLE=1 BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=testnet3 ./start_bitcoind.sh -testnet
LN_DIR=~/lnd/testnet3_data
mkdir -p ${LN_DIR}
BLOCKDATA_DIR=${DATA_DIR} LNDATA_DIR=${LN_DIR} NETWORKNAME=testnet3 ./start_lightningd.sh --network=testnet
```

#### regtest:
```bash
DATA_DIR=~/btcd/regtest_data
mkdir -p ${DATA_DIR}
LN_ENABLE=1 BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=regtest ./start_bitcoind.sh -regtest
LN_DIR=~/lnd/regtest_data
mkdir -p ${LN_DIR}
BLOCKDATA_DIR=${DATA_DIR} LNDATA_DIR=${LN_DIR} NETWORKNAME=regtest ./start_lightningd.sh --network=regtest
```

### RPC calls
Replace `%networkname%` with bitcoind container name, such as `mainnet`, `testnet3` or `regtest`.
```bash
NETWORKNAME=%networkname% ./lightning-cli.sh getinfo
```

### __Shell__
Replace `%networkname%` with bitcoind container name, such as `mainnet`, `testnet3` or `regtest`.
```bash
NETWORKNAME=%networkname% ./attach_lightningd.sh
```

## Example 1: Payment test with lightning-cli.sh
Replace `%networkname%` with bitcoind container name, such as `mainnet`, `testnet3` or `regtest`.
* Generate your lightning node wallet address and send bitcoins to the address
```bash
NETWORKNAME=%networkname% ./lightning-cli.sh newaddr
```

NOTE: For testnet, you can use testnet faucet to send bitcoins to your address.

* Connect to a node then open a channel
```bash
NETWORKNAME=%networkname% ./lightning-cli.sh connect 0277ab358175396a07151dfc0fed59a6765bffa58c5d4112b292d73bb120c82458 18.188.81.20
NETWORKNAME=%networkname% ./lightning-cli.sh fundchannel 0277ab358175396a07151dfc0fed59a6765bffa58c5d4112b292d73bb120c82458 1000000
```

NOTE: you can find the node with
```bash
NETWORKNAME=%networkname% ./lightning-cli.sh listnodes
```
And make sure you have enough funds for your lighting payment test

* Then you can pay everything in the lighting network
```bash
NETWORKNAME=%networkname% ./lightning-cli.sh pay `%paymentaddress%`
```

NOTE: For testnet, you can use https://htlc.me or https://yalls.org

## Example 2: Payment test with Android
Replace `%networkname%` with bitcoind container name, such as `mainnet`, `testnet3` or `regtest`.
Find your node info with
```bash
NETWORKNAME=%networkname% ./lightning-cli.sh getinfo
```

Then download the Eclair Wallet, then connect to our node, do the payment in app.


## Reference
* [Run your own mainnet Lightning Node](https://medium.com/@dougvk/run-your-own-mainnet-lightning-node-2d2eab628a8b)
