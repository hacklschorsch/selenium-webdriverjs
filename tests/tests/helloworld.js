// Small example of using WebdriverJS from
// http://code.google.com/p/selenium/wiki/WebDriverJs

var webdriver = require('selenium-webdriverjs');

var driver = new webdriver.Builder().
    usingServer('http://localhost:4444/wd/hub').
    withCapabilities({
      'browserName': 'firefox',
      'version': '',
      'platform': 'ANY',
      'javascriptEnabled': true
    }).
    build();

driver.get('http://www.google.com');
driver.findElement(webdriver.By.name('q')).sendKeys('webdriver');
driver.findElement(webdriver.By.name('btnG')).click();
driver.getTitle().then(function(title) {
  require('assert').equal('webdriver - Google Search', title);

});

driver.quit();

