gulp = require('gulp')

gulp.task('build', [
	'browserify'
  'stylus'
  'images'
  'fonts'
], (err) ->
	gulp.start('test')
)