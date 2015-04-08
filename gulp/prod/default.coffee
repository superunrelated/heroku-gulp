gulp = require('gulp')

gulp.task('default', ['views', 'server'], () ->
	gulp.start('build')
)