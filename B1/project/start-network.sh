cd ./fabric-samples/test-network
./network.sh down
./network.sh up createChannel -c blockchain2023
./network.sh deployCC -c blockchain2023 -ccn basic -ccp ../../chaincode -ccl javascript -cci InitLedger -ccep "OR('Org1MSP.peer','Org2MSP.peer')"