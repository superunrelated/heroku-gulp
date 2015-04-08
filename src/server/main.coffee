app = require('./app')
debug = require('debug')('herokugulp:main')
http = require('http')

port = process.env.PORT or 3000

onError = (error) ->
  if error.syscall isnt 'listen'
    throw error

  # handle specific listen errors with friendly messages
  switch error.code
    when 'EACCES'
      console.error(port + ' requires elevated privileges')
      process.exit(1)
    when 'EADDRINUSE'
      console.error(port + ' is already in use')
      process.exit(1)
    else
      throw error
  return

onListening = () ->
  debug('Listening on ' + port)

app.set('port', port)
server = http.createServer(app)
server.on('error', onError)
server.on('listening', onListening)
server.listen(port)