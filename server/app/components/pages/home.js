var React;

React = require('react');

module.exports = React.createClass({
  displayName: 'Home',
  render: function() {
    return React.createElement("div", {
      "className": 'page home'
    }, React.createElement("div", null, "Home page"));
  }
});
