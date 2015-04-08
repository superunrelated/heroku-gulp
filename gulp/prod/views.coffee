gulp = require('gulp')

gulp.task('views', ->
	gulp.src('./src/server/views/**')
		.pipe gulp.dest('./server/server/views')
)


