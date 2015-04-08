var React;

React = require('react');

module.exports = React.createClass({
  displayName: 'About',
  render: function() {
    return React.createElement("div", {
      "className": 'page about'
    }, React.createElement("div", null, "About page"), this.props.title, this.props.body);
  }
});
