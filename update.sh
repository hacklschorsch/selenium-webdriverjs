#!/bin/bash

# Scope: Update selenium-webdriverjs: Fetch latest upstream code & compile.
# Usage: Call from selenium-webdriverjs root directory.
# Notes: Written and tested on Ubuntu Linux.
# Dependencies: JRE, git, maybe GNU extensions to Unix tools (grep, sed, date)
# Author: Florian Sesser <fs@it-agenten.com>
# Date: 2012-08-12

# Set up shell script
set -u
set -e

# Set up directories
install -d build
mv selenium-webdriver build/selenium-webdriver.`date +'%F_%T'`

# Fetch latest code from SeleniumHQ
cd build
if [ -d master ]; then
	cd master
	git pull
else
	git clone http://selenium.googlecode.com/git/ master
	cd master
fi

# The "real" build process:
./go //javascript/node:selenium-webdriver
# done.

cp -ar build/javascript/node/selenium-webdriver ../../

# Add new version string to package.json:
UPSTREAM_DATE=$(git log -1 --format='%ci' | awk '{print $1}')
sed -i "s/\([0-9]\)\.\([0-9]\)\.\([0-9]\)-[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\+/\1.\2.\3-${UPSTREAM_DATE}/" ../../package.json


# set -e makes this script fail early if any operation fails, so if we're here:
echo Update successful.

# That should be it, EOT.

