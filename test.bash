#!/bin/bash


# Spin up the docker with 1 master and 5 slaves

docker-compose up -d
sleep 60

masterappcontainer=$(docker container ls -f name=project_master| awk '{printf("%s\n",$NF)}' | grep -v 'NAMES')
clientcontainers=$(docker container ls -f name=project_client| awk '{printf("%s\n",$NF)}' | grep -v 'NAMES')
slaveappcontainers=$(docker container ls -f name=project_slave| awk '{printf("%s\n",$NF)}' | grep -v 'NAMES')
counter=0
slaveappcontainers2=(project_slave-app-1_1_2863386e3d99:3001 project_slave-app-2_1_944be6513d74:3002 project_slave-app-3_1_42221fd4bc4e:3003 project_slave-app-4_1_5fb9ce83fcc9:3004 project_slave-app-5_1_ce42f1d7552f:3005)

echo "\nValidating if the Rails App processes are up"

if [ $(docker container ls | awk '{printf("%s\n",$NF)}' | grep -v 'NAMES' | wc -l) -eq 12 ]
  then
    echo "All environments are up"
else
  echo "Not all environments are up"
fi

#Slave to Master connectivity test:
echo "\nValidating Slave to Master connectivity"

for container in $slaveappcontainers
do
  docker exec -it $container sh -c "curl -s http://$masterappcontainer:3000" | grep 'Hello World'
done


#Slave to Slave connectivity test:
echo "\nValidating Slave to Slave connectivity"

for container in $slaveappcontainers
do
  for i in {1..5}
    do
      if [ `docker exec -it $container sh -c "curl -s http://$slaveappcontainers2[i]" | grep 'Hello World' | wc -l` -gt 0 ]
      then
        counter++
      fi
    done
done
if [ $counter -eq 0 ]
then
  echo "There is no Slave to slave connectivity"
fi
