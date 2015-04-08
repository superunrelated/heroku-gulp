React = require('react')

module.exports = React.createClass(
  displayName: 'Home'

  render: () ->
    return (
      <div className='page home'>
      	<img src="/img/omg.jpg"/>
        <h1>OMG</h1>
      </div>
    )
)
