gulp = require('gulp')

gulp.task('watch', [ 'setwatch', 'browsersync'], ->
  gulp.watch 'src/stylus/**', [ 'stylus' ]
  gulp.watch 'src/images/**', [ 'images' ]
  # Note: The browserify task handles js recompiling with watchify
  return
)