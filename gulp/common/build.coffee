gulp = require('gulp')

gulp.task('build', [
  'browserify'
  'stylus'
  'images'
  'copy'
])