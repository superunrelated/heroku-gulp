gulp = require('gulp')

gulp.task('watch', [ 'setWatch', 'browserSync'], ->
  gulp.watch 'src/stylus/**', [ 'stylus' ]
  gulp.watch 'src/images/**', [ 'images' ]
  # Note: The browserify task handles js recompiling with watchify
  return
)