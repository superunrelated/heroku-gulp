require('coffee-script/register')
gulp = require('gulp')
mocha = require('gulp-mocha')

gulp.task('test', ->

  console.log('--------------------------------------------')
  console.log(' Running tests')
  console.log('--------------------------------------------')

  gulp.src([ 'test/**/*test.coffee' ], read:false)
    .pipe(mocha(
        ui: 'bdd'
        compilers: 'coffee:coffee-script/register'
        globals: 'environment,log'
        recursive: true
    ))
    .once('error', () ->
      process.exit(1)
    )
    .once('end', () ->
      process.exit()
    )
)