gulp = require('gulp')

gulp.task('default', ['views', 'server', 'build'], () ->
	gulp.start('test')
)