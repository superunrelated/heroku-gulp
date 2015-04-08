var App, Entrypoint, React, app, _,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

_ = require('lodash');

React = require('react');

Entrypoint = require('./entrypoint');

module.exports = App = (function() {
  function App() {
    this.init = __bind(this.init, this);
  }

  App.prototype.init = function() {
    var elm, props;
    elm = window.document.getElementById('props');
    props = JSON.parse(elm.innerHTML);
    return Entrypoint.render(props, (function(_this) {
      return function(err, state) {
        return _this.state = state;
      };
    })(this));
  };

  return App;

})();

app = new App();

app.init();
