_ = require('lodash')
React = require('react')
Entrypoint = require('./entrypoint')

module.exports = class App
  constructor: () ->

  init: () =>
    elm = window.document.getElementById('props')
    props = JSON.parse(elm.innerHTML)
    Entrypoint.render(props, (err, state) =>
      @state = state
    )

app = new App()
app.init()