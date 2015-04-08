var React, Router, Routes;

React = require('react/addons');

Router = require('react-router');

Routes = require('./routes');

module.exports = {
  renderToString: (function(_this) {
    return function(path, props, cb) {
      var router;
      router = Router.create({
        routes: Routes,
        location: path,
        onAbort: function(abortReason) {
          var params, query, to, url;
          if (abortReason.constructor.name === 'Redirect') {
            to = abortReason.to, params = abortReason.params, query = abortReason.query;
            url = router.makePath(to, params, query);
            return cb(null, url);
          } else {
            return cb(abortReason);
          }
        }
      });
      return router.run(function(Handler, state) {
        return cb(null, null, React.renderToString(React.createElement(Handler, React.__spread({}, props))));
      });
    };
  })(this),
  render: (function(_this) {
    return function(props, cb) {
      return Router.run(Routes, Router.HistoryLocation, function(Handler, state) {
        React.render(React.createElement(Handler, React.__spread({}, props)), document.getElementById('react'));
        return cb(null, state);
      });
    };
  })(this)
};
