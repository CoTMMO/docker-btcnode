# Bitcoin Cash fullnode in Docker

There are 3 running modes in the Bitcoin Cash.
mainnet, testnet3 and regtest

In order to start the fullnode quickly, Docker is the best choice.

## Files
* `install_bitcoind.sh`:  Install the latest bitcoin-abc docker image
* `start_bitcoind.sh`: Start Bitcoin Cash fullnode with parameters
* `bitcoin-cli.sh`: Bitcoin Cash cli wrapper for different fullnode mode
* `attach-bitcoind.sh`: Attach to bitcoin-abc docker's shell

## Fullnode guide
First you need to install Docker first, then run `./install_bitcoind.sh` once.
After that you can choose the mode you like.

### Start a BCH fullnode in mainnet mode
* __Start__ (Run the following scripts in Bash)
```bash
DATA_DIR=~/btcd/mainnet_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=mainnet ./start_bitcoind.sh
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`NETWORKNAME`: Set the docker instance name

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of bitcoin-abc

* __RPC call__ (eg: getmininginfo)
```bash
NETWORKNAME=mainnet ./bitcoin-cli.sh getmininginfo
```

* __Shell__
```bash
NETWORKNAME=mainnet ./attach_bitcoind.sh
```

### Start a BCH fullnode in Testnet3 mode
* __Start__ (Run the following scripts in Bash)
```bash
DATA_DIR=~/btcd/testnet3_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=testnet3 ./start_bitcoind.sh -testnet
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`NETWORKNAME`: Set the docker instance name

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of bitcoin-abc

* __RPC call__ (eg: getmininginfo)
```bash
NETWORKNAME=testnet3 ./bitcoin-cli.sh -testnet getmininginfo
```

* __Shell__
```bash
NETWORKNAME=testnet3 ./attach_bitcoind.sh
```

### Start a BCH fullnode in regtest mode
* __Start__ (Run the following scripts in Bash)
```bash
DATA_DIR=~/btcd/regtest_data
mkdir -p ${DATA_DIR}
BLOCKDATA_DIR=${DATA_DIR} NETWORKNAME=regnet ./start_bitcoind.sh -regtest
```
NOTE:

`DATA_DIR`: Used for block data storage, choose the directory your like.

`NETWORKNAME`: Set the docker instance name

`CONSOLE`: Override the entrypoint e.g. CONSOLE=bash, it will start the bash instead of bitcoin-abc

* __RPC call__ (eg: getmininginfo)
```bash
NETWORKNAME=regnet ./bitcoin-cli.sh -regtest getmininginfo
```

* __Shell__
```bash
NETWORKNAME=regnet ./attach_bitcoind.sh
```

## Docker usage
### Install Docker on Ubuntu 16.04 (Need `sudo`)
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}
```

## Reference
### Docker
* [Bitcoin Core Docker images](https://github.com/ruimarinho/docker-bitcoin-core)
* [How to install and use Docker in Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)
* [Change default image container location for Docker](https://sanenthusiast.com/change-default-image-container-location-docker/)
* https://denibertovic.com/posts/handling-permissions-with-docker-volumes/

### Testnet
* https://en.bitcoin.it/wiki/Testnet
* https://en.bitcoin.it/wiki/Running_Bitcoin
* [How to test applications?](https://bitcoinj.github.io/testing)
* [Creating your own experimental Bitcoin network](https://geraldkaszuba.com/creating-your-own-experimental-bitcoin-network/)
* [Setting up a Private Regtest Blockchain](https://samsclass.info/141/proj/pBitc1.htm)
* [Adding a Second Node to your Private Regtest Blockchain](https://samsclass.info/141/proj/pBitc2.htm)
