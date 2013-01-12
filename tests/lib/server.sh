#!/bin/bash

ROOTDIR="$( cd "$( dirname "$0")" && pwd )"
TMP=$ROOTDIR/tmp
SELENIUM_VERSION=2.28.0

COMMAND=$1

source $ROOTDIR/functions.sh

checkSelenium() {
	curl -s -f http://localhost:4444/selenium-server
}

mkdir -p $TMP

download http://selenium.googlecode.com/files/selenium-server-standalone-$SELENIUM_VERSION.jar $TMP/selenium-server-standalone-$SELENIUM_VERSION.jar

if [[ $COMMAND == "stop" ]] || [[ $COMMAND == "start" ]] ; then
    stopbg selenium
    rm -f $TMP/selenium.*
fi

if [[ $COMMAND == "start" ]]; then
    checkSelenium || startbg selenium java -jar $TMP/selenium-server-standalone-$SELENIUM_VERSION.jar
    waitfor checkSelenium
fi

