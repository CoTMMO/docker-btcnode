# bitcore fullnode in Docker

There are 3 running modes in the bitcore.
mainnet, testnet3 and regtest

The docker image supports insight-api service

you can access it through http://HOST_IP:${API_PORT}/insight-api

`HOST_IP` is the ip address of the host that runs the docker service.

In order to start the fullnode quickly, Docker is the best choice.

## Files
* `build_docker_bitcore.sh`: Build the docker-bitcore image
* `start_bitcore.sh`: Start the bitcore fullnode with parameters
* `bitcoin-cli.sh`: Bitcoin cli wrapper for different fullnode mode
* `insight-api.sh`: Insight api helper
* `attach_bitcore.sh`: Attach to docker-bitcore's shell
* `bitcore_logs.sh`: Display the log of container

## Fullnode guide
First you need to install Docker first, then run `./build_docker_bitcore.sh` once.
it will use your ssh private key to install the private lib from github repo,
you can override the default ssh key with
```bash
PRIVATE_KEY=`cat ${HOME}/.ssh/my_private_ssh_key` ./build_docker_bitcore.sh
```
After that you can choose the mode you like.

### Start a BTC fullnode in mainnet mode
* __Start__ (Run the following scripts in Bash)
```bash
DATA_DIR=~/btcd/mainnet_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=mainnet API_PORT=3001 ./start_bitcore.sh
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`NETWORKNAME`: Set the docker instance name

`API_PORT`: Used for insight api

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of bitcore full node

* __RPC call__ (eg: getmininginfo)
```bash
NETWORKNAME=mainnet ./bitcoin-cli.sh getmininginfo
```

* __Insigh API__ (eg: /insight-api/block-index/0)
```bash
API_PORT=3001 ./insight-api.sh /insight-api/block-index/0
```

* __Shell__
```bash
NETWORKNAME=mainnet ./attach_bitcore.sh
```

* __Log__
```bash
NETWORKNAME=mainnet ./bitcore_logs.sh
```

### Start a BTC fullnode in Testnet3 mode
* __Start__ (Run the following scripts in Bash)
```bash
DATA_DIR=~/btcd/testnet3_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=testnet3 API_PORT=3001 ./start_bitcore.sh -testnet
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`NETWORKNAME`: Set the docker instance name

`API_PORT`: Used for insight api

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of bitcore full node

* __RPC call__ (eg: getmininginfo)
```bash
NETWORKNAME=testnet3 ./bitcoin-cli.sh -testnet getmininginfo
```

* __Insigh API__ (eg: /insight-api/block-index/0)
```bash
API_PORT=3001 ./insight-api.sh /insight-api/block-index/0
```

* __Shell__
```bash
NETWORKNAME=testnet3 ./attach_bitcore.sh
```

* __Log__
```bash
NETWORKNAME=testnet3 ./bitcore_logs.sh
```

### Start a BTC fullnode in regtest mode
* __Start__ (Run the following scripts in Bash)
```bash
DATA_DIR=~/btcd/regtest_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=regnet API_PORT=3001 ./start_bitcore.sh -regtest
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`NETWORKNAME`: Set the docker instance name

`API_PORT`: Used for insight api

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of bitcore full node

* __RPC call__ (eg: getmininginfo)
```bash
NETWORKNAME=regnet ./bitcoin-cli.sh -regtest getmininginfo
```

* __Insigh API__ (eg: /insight-api/block-index/0)
```bash
API_PORT=3001 ./insight-api.sh /insight-api/block-index/0
```

* __Shell__
```bash
NETWORKNAME=regnet ./attach_bitcore.sh
```
* __Log__
```bash
NETWORKNAME=regnet ./bitcore_logs.sh
```
