/**
 * Created by ld on 16/10/17.
 */
if (window.initMochaPhantomJS && window.location.search.indexOf('skip') === -1) {
    initMochaPhantomJS()
}
mocha.ui('bdd');
expect = chai.expect;

mocha.run();