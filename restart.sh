#/bin/bash!
sudo rm -rf node1/*
sudo rm -rf node2/*
sudo rm -rf node3/*

geth account new --datadir node1 --password pass
geth account new --datadir node2 --password pass
geth account new --datadir node3 --password pass

cp pass ./node1

ADD1=$(cat node1/keystore/* | awk -F\" '{print $4}')
ADD2=$(cat node2/keystore/* | awk -F\" '{print $4}')
ADD3=$(cat node3/keystore/* | awk -F\" '{print $4}')

echo ADD1=$ADD1 > .env

sed -e 's/address1/'"$ADD1"'/g' genesis-template.json | sed -e 's/address2/'"$ADD2"'/g' | sed -e 's/address3/'"$ADD3"'/g' > genesis.json
sed -e 's/address1/'"$ADD1"'/g' truffle-config.js > truffle-project/truffle-config.js

geth init --datadir node1 genesis.json
geth init --datadir node2 genesis.json
geth init --datadir node3 genesis.json

docker-compose up node1 &
sleep 5s
ENODE=$(docker exec node1 geth attach geth.ipc --exec 'admin.nodeInfo.enode')
docker-compose stop

sed -e '2c\'"$ENODE"'' static-nodes.json > node1/geth/static-nodes.json
sed -e '2c\'"$ENODE"'' static-nodes.json > node2/geth/static-nodes.json
sed -e '2c\'"$ENODE"'' static-nodes.json > node3/geth/static-nodes.json
