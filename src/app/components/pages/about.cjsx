React = require('react')

module.exports = React.createClass(
  displayName: 'About'

  render: () ->
    return (
      <div className='page about'>
        <div>About page</div>
        {@props.title}
        {@props.body}
      </div>
    )
)
