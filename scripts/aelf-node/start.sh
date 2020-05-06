# #!/bin/bash
# dir=`pwd`
# ip=`ip a | grep eth0 |grep 'inet' | awk -F/ '{print $1}'| awk '{print $2}'`
# sudo sed -i "s/172.31.8.57/$ip/g" appsettings.json 
# sudo docker pull aelf/node:testnet-v0.9.2
# sudo docker run -itd --name aelf-node-test -v $dir:/opt/node -v $dir/keys:/root/.local/share/aelf/keys -p 8200:8000 -p 6801:6800 -w /opt/node aelf/node:testnet-v0.9.2 dotnet /app/AElf.Launcher.dll
# sleep 30
# height=`curl -s http://$ip:8200/api/blockChain/blockHeight`
# echo "height is $height"
#!/bin/bash
ip=`ip a | grep eth0 |grep 'inet' | awk -F/ '{print $1}'| awk '{print $2}'`
sudo apt update && apt install unzip
sudo mkdir -p /home/ubuntu/.ssh/aelf/keys && sudo mkdir -p /root/.ssh/aelf/keys
cd ../../
wget https://github.com/AElfProject/AElf/releases/download/v1.0.0-preview1/aelf.zip
sudo unzip aelf.zip
sed -i "s/127.0.0.1/$ip/g" scripts/aelf-node/appsettings.json
sudo mkdir -p aelf/aelf/keys
sudo cp scripts/aelf-node/keys/*.json aelf/aelf/keys/
sudo cp scripts/aelf-node/app* aelf/
echo "start node"
cd aelf && sudo dotnet AElf.Launcher.dll  >/dev/null 2>&1 &
sleep 30
height=`curl -s http://$ip:8000/api/blockChain/blockHeight`
echo "height is $height"
