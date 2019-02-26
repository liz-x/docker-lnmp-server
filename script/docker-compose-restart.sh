#!/bin/bash

dir=$(ls -d /websvr/compose/*)
for i in $dir
do
    cd &i
    docker-compose down && docker-compose up -d
    cd ..
done
