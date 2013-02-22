#!/bin/bash

set -e

ROOTDIR="$( cd "$( dirname "$0")" && pwd )"

cd $ROOTDIR

echo -n 'Quick syntax check: ' ; node ../../selenium-webdriver/index.js && echo OK.
echo -n 'Simple hello world test: ' ; node ../tests/helloworld.js && echo OK.
# ../node_modules/.bin/mocha -t 120000 --reporter spec ../testsuite.js

exit $?
