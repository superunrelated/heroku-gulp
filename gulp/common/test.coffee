require('coffee-script/register')
gulp = require('gulp')
mocha = require('gulp-mocha')

gulp.task('test', ->
  gulp.src([ 'test/**/*test.coffee' ], read:false)
    .pipe(
      mocha(
        ui: 'bdd'
        compilers: 'coffee:coffee-script/register'
        globals: 'environment,log'
        recursive: true
      )
    )
)