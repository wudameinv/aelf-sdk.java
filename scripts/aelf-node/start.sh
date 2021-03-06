#!/bin/bash
dir=`pwd`
pwd
ip=`ip a | grep eth0 |grep 'inet' | awk -F/ '{print $1}'| awk '{print $2}'`
sudo sed -i "s/127.0.0.1/$ip/g" appsettings.json
# sudo sed -i "s/127.0.0.1/$ip/g" ../../AElfClientTest/src/main/java/io/aelf/test/BlockChainSdkTest.java
# sudo sed -i "s/127.0.0.1/$ip/g" ../../AElfClientTest/src/main/java/io/aelf/test/NetSdkTest.java
sudo apt update && apt install unzip
sudo mkdir -p /home/ubuntu/.ssh/aelf/keys && sudo mkdir -p /root/.ssh/aelf/keys
cd ../../
wget https://github.com/AElfProject/AElf/releases/download/v1.0.0-preview1/aelf.zip
sudo unzip aelf.zip
sudo mkdir -p aelf/aelf/keys
sudo cp scripts/aelf-node/keys/*.json aelf/aelf/keys/
sudo cp scripts/aelf-node/app* aelf/
echo "start node"
cd aelf && sudo dotnet AElf.Launcher.dll  >/dev/null 2>&1 &
sleep 30
height=`curl -s http://$ip:8000/api/blockChain/blockHeight`
echo "height is $height"
