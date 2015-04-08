_ = require('lodash')
React = require('react/addons')
TransitionGroup = require('./addons/timeout-transition-group') # React.addons.CSSTransitionGroup
Router = require('react-router')
RouteHandler = Router.RouteHandler

Menu = require('./elements/menu')

module.exports = React.createClass(
  displayName: 'App'
  
  render: () ->
    return (
      <div className="container">
        <header className="global">
          <Menu/>
        </header>
        <TransitionGroup component="div" className="pages" transitionName="page" enterTimeout={1500} leaveTimeout={500} enterCallback={@enterCallback}>
          <RouteHandler {...@props} />
        </TransitionGroup>
      </div>
    )
)