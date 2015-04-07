gulp = require('gulp')
browserify = require('browserify')
coffeereactify = require('coffee-reactify')
watchify = require('watchify')
bundleLogger = require('../util/bundleLogger')
handleErrors = require('../util/handleErrors')
source = require('vinyl-source-stream')

files = [
  {
    input: [ './src/app/app.coffee' ]
    output: 'main.js'
  }
  {
    input: [ './src/admin/admin.coffee' ]
    output: 'admin.js'
  }
]

createBundle = (options) ->
  bundler = browserify(
    entries: options.input
    extensions: [
      '.coffee'
      '.cjsx'
    ]
    debug: true
    cache: {}
    packageCache: {}
    fullPaths: true
    transform: [coffeereactify]
  )

  rebundle = ->
    bundler
      .bundle()
      .on('error', handleErrors)
      .pipe(source(options.output))
      .pipe(gulp.dest('./public/js/'))
      .on('end', () ->

      )

  if global.isWatching
    bundler = watchify(bundler)
    bundler.on('update', rebundle)
  rebundle()

createBundles = (bundles) ->
  for k of bundles
    bundle = bundles[k]
    createBundle(
      input: bundle.input
      output: bundle.output
    )

gulp.task 'browserify', ->
  createBundles(files)