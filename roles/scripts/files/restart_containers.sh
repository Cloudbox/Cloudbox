#!/bin/bash
#########################################################################
# Title:         Restart Containers                                     #
# Author:        desimaniac                                             #
# URL:           https://github.com/Cloudbox/Cloudbox                   #
# Description:   Stop running containers and start them back up.        #
# --                                                                    #
# Part of the Cloudbox project: https://cloudbox.rocks                  #
#########################################################################
# GNU General Public License v3.0                                       #
#########################################################################

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
    docker=$(docker start $container)
done
