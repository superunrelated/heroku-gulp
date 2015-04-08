
path = require('path')
express = require('express')
morgan = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

Entrypoint = require('../app/entrypoint')

app = express()

app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')

app.use(morgan('combined', 
  skip: (req, res) ->
    return res.statusCode < 400
))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded(extended: false))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, '../../public')))

app.get('*', (req, res) =>

  # props could be comming from anywhere!
  props = {
    title: "This is React"
    body: "Isnt it awesome?"
  }

  Entrypoint.renderToString(req.path, props, (err, redirect, react) =>
    if err 
      return next(err)

    if redirect 
      console.log("redirect", redirect)
      return res.redirect(redirect)

    result = {
    #   browsersync: serverConfig.browsersync
    #   browserConfig: browserConfig
    #   env: process.env.NODE_ENV
    #   title: "Stolleken"
    #   store: JSON.stringify(data)
      props: JSON.stringify(props)
      react: react
    }
    res.render('index', result)
  )
)

app.use((err, req, res, next) ->
  res.status(err.status || 500)
  if (app.get('env') isnt 'development') 
    err = {}

  if req.xhr
    res.json(
      status: false
      message: err.message
      error: err
    )
  else
    res.render('error', 
      message: err.message
      error: err
    )
)

module.exports = app

