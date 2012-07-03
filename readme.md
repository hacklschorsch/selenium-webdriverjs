# selenium-webdriverjs

This is an [npm](http://npmjs.org/) package of a JavaScript binding for Selenium2 (AKA. WebDriver) from [SeleniumHQ](http://seleniumhq.org/) (see http://code.google.com/p/selenium/wiki/WebDriverJs.

Of the [different](https://github.com/admc/wd/) [available](https://github.com/Camme/webdriverjs/) [options](https://github.com/LearnBoost/soda) to drive Selenium2 from node.js I liked that adapter the most. Unfortunately, there was no npm package for it. This is what I am trying to solve.

## Files

* webdriver.js
** The compiled file from the Selenium2 guys. This is what you get when you run "./go webdriverjs" in the checked-out [Subversion repo of Selenium2](http://code.google.com/p/selenium/source/checkout).
* selenium-src/
** This directory contains all the sources for the compiled file above.
** It's included because of the license texts (most of which have to be included when re-distributing) and documentation (which is stripped in the compiled version above, but can be a handy reference).

## License

I put my own work (the packaging) into public domain (or whatever very free license is compatible to the licenses of the actual code).
The code has different licenses attached: Apache, MIT, BSD, maybe more; I included the source files in hoping to comply with all the "keep this license text in your copy" regulations.
