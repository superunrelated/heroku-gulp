React = require('react/addons')
Router = require('react-router')
Routes = require('./routes')

module.exports = 
  renderToString: (path, props, cb) =>
    router = Router.create(
      routes: Routes
      location: path
      onAbort: (abortReason) =>
        if abortReason.constructor.name is 'Redirect'
          {to, params, query} = abortReason
          url = router.makePath(to, params, query)
          cb(null, url)
        else
          cb(abortReason)
    )

    router.run((Handler, state) ->
      cb(null, null, React.renderToString(<Handler {...props} />))
    )

  render: (props, cb) =>
    Router.run(Routes, Router.HistoryLocation, (Handler, state) =>
      React.render(<Handler {...props} />, document.getElementById('react'))
      cb(null, state)
    )


