#!/bin/bash

# Scope: Update selenium-webdriverjs: Fetch SVN trunk & compile.
# Usage: Call from selenium-webdriverjs root directory.
# Notes: Written and tested on Ubuntu Linux.
# Dependencies: JRE, svn, maybe GNU extensions to Unix tools (grep, sed, date)
# Author: Florian Sesser <fs@it-agenten.com>
# Date: 2012-08-12

# Set up shell script
set -u
set -e

# Set up directories
install -d build
mv selenium-src build/selenium-src.`date +'%F_%T'`
install -d selenium-src/javascript/webdriver/

# Fetch latest code from SeleniumHQ
cd build
svn checkout http://selenium.googlecode.com/svn/trunk
cd trunk

# The "real" build process:
./go webdriverjs
# done.

cp build/javascript/webdriver/webdriver.js ../../
svn export --force javascript/webdriver/ ../../selenium-src/javascript/webdriver/

# Add new version string to package.json:
UPSTREAM_REV=$(svn info | grep '^Revision:' | sed 's/[^0-9]//g')
sed -i "s/\([0-9]\)\.\([0-9]\)\.\([0-9]\)-r[0-9]\+/\1.\2.\3-r${UPSTREAM_REV}/" ../../package.json

# That should be it, EOT.

