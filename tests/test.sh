#!/bin/bash

export PATH=$PATH:`pwd`/node_modules/.bin

source lib/functions.sh

trap ErrorHandler ERR
trap ExitHandler EXIT

# Keep server running in the background, so IDE can also use it.

(
    trap ErrorHandler ERR
    trap ExitHandler EXIT

    echo "****** Selenium"
    ./lib/server.sh stop
    ./lib/server.sh start
    ./lib/runtests.sh 
    ./lib/server.sh stop
)
