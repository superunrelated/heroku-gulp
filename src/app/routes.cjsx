React = require('react')
Router = require('react-router')
Route = Router.Route
NotFoundRoute = Router.NotFoundRoute
DefaultRoute = Router.DefaultRoute

Body = require('./components/body')
Home = require('./components/pages/home')
About = require('./components/pages/about')

module.exports = (
  <Route name="app" path="/" handler={Body}>
    <NotFoundRoute handler={Home}/>
    <DefaultRoute handler={Home}/>
    
    <Route name="home" path="home" handler={Home} />
    <Route name="about" path="about" handler={About} />
  </Route>
)