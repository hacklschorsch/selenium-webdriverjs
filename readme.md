UPDATE: Selenium HQ is now providing an official NPM package of its own, rendering this project obsolete. See https://npmjs.org/package/selenium-webdriver and https://code.google.com/p/selenium/wiki/WebDriverJs#Installing_from_NPM.

# selenium-webdriverjs

[![Build Status](https://travis-ci.org/hacklschorsch/selenium-webdriverjs.png)](https://travis-ci.org/hacklschorsch/selenium-webdriverjs)

This is an [npm](http://npmjs.org/) package of a JavaScript binding for [Selenium2 (AKA. WebDriver)](http://seleniumhq.org/projects/webdriver/) from [SeleniumHQ](http://seleniumhq.org/) (see http://code.google.com/p/selenium/wiki/WebDriverJs).

Of the [different](https://github.com/admc/wd/) [available](https://github.com/Camme/webdriverjs/) [options](https://github.com/LearnBoost/soda) to drive Selenium2 from node.js I liked that adapter the most. Unfortunately, there was no npm package for it. This is what I am trying to solve.

## Documentation

Have a look at the [wiki of WebdriverJS at the Google Code page](http://code.google.com/p/selenium/wiki/WebDriverJs).

You can use selenium-webdriverjs like this:

    var webdriver = require('selenium-webdriverjs'),
        client    = new webdriver.Builder().build();

    client.get('http://github.com');

See this small [UI testsuite](https://github.com/froh42/multi/blob/master/selenium/testsuite.js) where I used the [mocha test runner](https://mochajs.org/) to run [Selenium2](http://seleniumhq.org/projects/webdriver/) tests.

## Files

* selenium-webdriver/*
  * The compiled output from the Selenium2 guys. This is what you get when you run "./go //javascript/node:selenium-webdriver" in the checked-out [Subversion repo of Selenium2](http://code.google.com/p/selenium/source/checkout).
* COPYING
  * Symlink to Selenium WebdriverJS's Apache License
* update.sh
  * Updates the package: Pulls SeleniumHQ GIT master, compiles selenium-webdriver for node and updates the package.json version string.
* tests/*
  * Beginnings of a self-test suite. Integrated with TravisCI.

## Issues

If you have any suggestions (or maybe even a finished patch) for the package I'd be most delighted to add it. I also welcome other contributors or willing maintainers.

Anything relating to the fine code itself please see the [issue tracker at the Google Code page](http://code.google.com/p/selenium/issues/).

## License

I put my work (the mere packaging) in the public domain, or, failing this (in countries where this is not possible) publish it under the same license as the original code (Apache License).

