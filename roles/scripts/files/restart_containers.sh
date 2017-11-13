#!/bin/bash
# Stop running containers and start them back up.

containers=$(comm -12 <(docker ps -a -q | sort) <(docker ps -q | sort))
for container in $containers;
do
    echo Stopping $container
    docker=$(docker stop $container)
done

sleep 10

for container in $containers;
do
    echo Starting $container
    docker=$(docker start -a $container)
done
