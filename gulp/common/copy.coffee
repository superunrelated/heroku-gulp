gulp = require('gulp')

gulp.task('copy', ->
  gulp.src('src/stylus/fonts/**')
  	.pipe(gulp.dest('public/css/fonts'))
)