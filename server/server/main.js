var app, debug, http, onError, onListening, port, server;

app = require('./app');

debug = require('debug')('herokugulp:main');

http = require('http');

port = process.env.PORT || 3000;

onError = function(error) {
  if (error.syscall !== 'listen') {
    throw error;
  }
  switch (error.code) {
    case 'EACCES':
      console.error(port + ' requires elevated privileges');
      process.exit(1);
      break;
    case 'EADDRINUSE':
      console.error(port + ' is already in use');
      process.exit(1);
      break;
    default:
      throw error;
  }
};

onListening = function() {
  return debug('Listening on ' + port);
};

app.set('port', port);

server = http.createServer(app);

server.on('error', onError);

server.on('listening', onListening);

server.listen(port);
