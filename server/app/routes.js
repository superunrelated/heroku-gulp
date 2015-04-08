var About, Body, DefaultRoute, Home, NotFoundRoute, React, Route, Router;

React = require('react');

Router = require('react-router');

Route = Router.Route;

NotFoundRoute = Router.NotFoundRoute;

DefaultRoute = Router.DefaultRoute;

Body = require('./components/body');

Home = require('./components/pages/home');

About = require('./components/pages/about');

module.exports = React.createElement(Route, {
  "name": "app",
  "path": "/",
  "handler": Body
}, React.createElement(NotFoundRoute, {
  "handler": Home
}), React.createElement(DefaultRoute, {
  "handler": Home
}), React.createElement(Route, {
  "name": "home",
  "path": "home",
  "handler": Home
}), React.createElement(Route, {
  "name": "about",
  "path": "about",
  "handler": About
}));
