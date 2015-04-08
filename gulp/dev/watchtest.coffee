gulp = require('gulp')

gulp.task('watchtest', ->
  gulp.watch [
    'src/**'
    'test/**'
  ], ['test']
  return
)