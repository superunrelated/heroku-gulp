var Menu, React, RouteHandler, Router, TransitionGroup, _;

_ = require('lodash');

React = require('react/addons');

TransitionGroup = require('./addons/timeout-transition-group');

Router = require('react-router');

RouteHandler = Router.RouteHandler;

Menu = require('./elements/menu');

module.exports = React.createClass({
  displayName: 'App',
  render: function() {
    return React.createElement("div", {
      "className": "container"
    }, React.createElement("header", {
      "className": "global"
    }, React.createElement(Menu, null)), React.createElement(TransitionGroup, {
      "component": "div",
      "className": "pages",
      "transitionName": "page",
      "enterTimeout": 1500.,
      "leaveTimeout": 500.,
      "enterCallback": this.enterCallback
    }, React.createElement(RouteHandler, React.__spread({}, this.props))));
  }
});
