gulp = require('gulp')

gulp.task('fonts', ->
  gulp.src('src/stylus/fonts/**')
  	.pipe(gulp.dest('public/css/fonts'))
)