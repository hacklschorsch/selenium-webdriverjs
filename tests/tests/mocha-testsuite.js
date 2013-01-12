// Mocha / Selenium Test suite for multi
// Depends: Selenium webdriver.js and mocha test runner

var assert = require("assert"),
    webdriver = require("selenium-webdriverjs");

var client = new webdriver.Builder()
//    usingServer('http://localhost:4444/wd/hub').
    .withCapabilities({
      'browserName': 'firefox',
      'version': '',
      'platform': 'ANY',
      'javascriptEnabled': true
    })
    .build();

// Prevent not failing tests due to not being ready
// http://seleniumhq.org/docs/04_webdriver_advanced.html#implicit-waits
client.manage().timeouts().implicitlyWait(10000);

// Construct URL to local file.
var test_url = "file://" + __dirname + "/../src/start.html";



describe("Run Selenium tests", function() {

    before(function(done) {
        client
            .get(test_url);

        client
            .findElement(webdriver.By.tagName("body"))
            .then(function(){done();});
    });

    after(function(done) {
        client
            .quit()
            .then(function(){done();});
    });

    describe('The start page', function() {
        it('should have a `Start game` link', function() {
            assert(client.findElement(webdriver.By.linkText("Start game")).isDisplayed());
        });
    });

    describe('The `Start game` link', function() {
        it('should lead us to the game page', function(done) {
            client
                .findElement(webdriver.By.linkText("Start game"))
                .click()
                .then(function(){
                    assert.ok(
                        client.findElement(webdriver.By.xpath("//input[@data-bind='value: currentExercise().result']"))
                              .then(function(){done();}));
                });
        });
    });

    describe('The game page', function() {
        it('should have a nice multiplication exercise for us to solve', function(done) {
            solveOneMulti(done);
        });

        it('should show a `Next exercise` link when correct', function(done) {
            client
                .findElement(webdriver.By.linkText("Next exercise"))
                .click()
                .then(function(){done();});
        });

        it('should have another multiplication exercise for us', function(done) {
            solveOneMulti(done);
        });

        xit('should be kept open for a couple more seconds', function(done) {
            // For the world to see!
            client.sleep(5000).then(function(){done();});
        });
    });
});




/* Test method library begins here */

// Solve a mult exercise
var solveOneMulti = function(done){
    // Uuaagh: We cannot hold state well in this async-o-rama,
    // so I copy the factors into the result field, eval() (!!)
    // its content and send the result back to the field.

    var field = client.findElement(webdriver.By.xpath("//input[@data-bind='value: currentExercise().result']"));
    field.clear();

    client
        .findElement(webdriver.By.xpath("//span[@data-bind='text: currentExercise().factor1']"))
        .getText()
        .then(function(text) {
            field.sendKeys(text + " * ");
            //console.log(text);
        });

    client
        .findElement(webdriver.By.xpath("//span[@data-bind='text: currentExercise().factor2']"))
        .getText()
        .then(function(text) {
            field.sendKeys(text);
            //console.log(text);
        });

    field
        .getAttribute("value")
        .then(function(text) {
            var result = eval(text);
            console.log(text + " = " + result);
            field.clear();
            field.sendKeys(result);
        });

    client
        .findElement(webdriver.By.css("body"))
        .click()
        .then(function(){done();});
};
