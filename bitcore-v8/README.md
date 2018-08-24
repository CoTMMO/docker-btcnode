# Bitcore Node v8.0.0 in Docker

Bitcore Node is a Multi-Chain full node solution, it is a high level API for the cryptocurrency.

Insight-ui will work as a separate module, and insight-api will be the bridge for insight-ui and Bitcore Node.

After you start the docker service, you can access the API through http://HOST_IP:${API_PORT}

`HOST_IP` is the ip address of the host that runs the docker service.

## Files
* `build_docker_bitcore.sh`: Build the docker-bitcore image
* `start_bitcore.sh`: Start the docker-bitcore with parameters
* `insight-api.sh`: Insight api helper
* `attach_bitcore.sh`: Attach to docker-bitcore's shell

## Usage
First you need to install Docker first, then run `./build_docker_bitcore.sh` once.

* __Start__ (Run the following scripts in Bash)

```bash
DATA_DIR=~/btcd/mainnet_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} API_PORT=3001 ./start_bitcore.sh
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`API_PORT`: Used for insight api

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of Bitcore Node


* __Insight API__ (eg: /api/BTC/mainnet/block/1, [API](https://github.com/bitpay/bitcore-node/tree/v8.0.0#transactions))

```bash
API_PORT=3001 ./insight-api.sh /api/BTC/mainnet/block/1
```

* __Shell__

```bash
./attach_bitcore.sh
```
