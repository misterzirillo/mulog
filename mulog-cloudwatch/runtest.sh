#!/bin/bash

function wait_for {
   echo "Checking if $1 is started."

   while [ "$(nc -z -w 5 $2 $3 || echo 1)" == "1" ] ; do
       echo "Waiting for $1 to start up..."
       sleep 3
   done
}


docker-compose up &

wait_for localstack localhost 4586

lein midje

docker-compose logs
docker-compose kill
docker-compose rm -f

exit 1
