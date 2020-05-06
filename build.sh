#!/bin/bash
AElfClient_path=AElfClient/
AElfClientTest_path=AElfClientTest/
for i in $AElfClient_path $AElfClientTest_path;
do
    cd $i && mvn clean package && mvn compile && cd ..
done
cd $AElfClientTest_path && mvn test
