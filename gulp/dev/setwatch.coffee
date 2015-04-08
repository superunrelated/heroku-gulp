gulp = require('gulp')

gulp.task 'setwatch', ->
  global.isWatching = true
  return