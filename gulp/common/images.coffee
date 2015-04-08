gulp = require('gulp')
changed = require('gulp-changed')
imagemin = require('gulp-imagemin')

gulp.task('images', ->
  dest = './public/img'
  gulp.src('./src/img/**')
  	.pipe(changed(dest))
  	.pipe(imagemin())
  	.pipe(gulp.dest(dest))
)