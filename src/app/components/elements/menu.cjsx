React = require('react/addons')
Router = require('react-router')
Link = Router.Link

module.exports = React.createClass(
  displayName: 'Menu'
  render: () ->
    return (
      <div className="menu">
        <Link to="home" className='link'>HOME</Link>
        <Link to="about" className='link'>ABOUT</Link>
      </div>
    )
)