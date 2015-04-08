var Link, React, Router;

React = require('react/addons');

Router = require('react-router');

Link = Router.Link;

module.exports = React.createClass({
  displayName: 'Menu',
  render: function() {
    return React.createElement("div", {
      "className": "menu"
    }, React.createElement(Link, {
      "to": "home",
      "className": 'link'
    }, "HOME"), React.createElement(Link, {
      "to": "about",
      "className": 'link'
    }, "ABOUT"));
  }
});
