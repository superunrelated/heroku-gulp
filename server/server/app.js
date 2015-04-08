var Entrypoint, app, bodyParser, cookieParser, express, morgan, path;

path = require('path');

express = require('express');

morgan = require('morgan');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

Entrypoint = require('../app/entrypoint');

app = express();

app.set('views', path.join(__dirname, 'views'));

app.set('view engine', 'jade');

app.use(morgan('combined', {
  skip: function(req, res) {
    return res.statusCode < 400;
  }
}));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({
  extended: false
}));

app.use(cookieParser());

app.use(express["static"](path.join(__dirname, '../../public')));

app.get('*', (function(_this) {
  return function(req, res) {
    var props;
    props = {
      title: "This is React",
      body: "Isnt it awesome?"
    };
    return Entrypoint.renderToString(req.path, props, function(err, redirect, react) {
      var result;
      if (err) {
        return next(err);
      }
      if (redirect) {
        console.log("redirect", redirect);
        return res.redirect(redirect);
      }
      result = {
        props: JSON.stringify(props),
        react: react
      };
      return res.render('index', result);
    });
  };
})(this));

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  if (app.get('env') !== 'development') {
    err = {};
  }
  if (req.xhr) {
    return res.json({
      status: false,
      message: err.message,
      error: err
    });
  } else {
    return res.render('error', {
      message: err.message,
      error: err
    });
  }
});

module.exports = app;
