React = require('react')

module.exports = React.createClass(
  displayName: 'About'

  render: () ->
    return (
      <div className='page about'>
        <h1>{@props.about.title}</h1>
        <p>{@props.about.body}</p>
      </div>
    )
)
