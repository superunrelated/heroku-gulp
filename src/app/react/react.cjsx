React = require('react')
Router = require('react-router')
Link = Router.Link

module.exports = React.createClass(
  displayName: 'React',
  render: () ->
    return (
      <html>
        <body>
          <div className="react">
            REACT IS IN THA HOUSE!
          </div>
        </body>
      </html>
    )
)

