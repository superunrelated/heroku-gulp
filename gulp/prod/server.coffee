gulp = require('gulp')
cjsx = require('gulp-cjsx')

gulp.task('server', ->
  gulp.src([
    './src/**/*.cjsx'
    './src/**/*.coffee'
  ])
    .pipe( cjsx(bare:true).on('error', console.log) )
    .pipe(gulp.dest('./server/'))
)
