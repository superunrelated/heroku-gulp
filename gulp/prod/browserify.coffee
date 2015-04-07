gulp = require('gulp')
cjsx = require('gulp-cjsx')
browserify = require('browserify')
uglify = require('gulp-uglify')
transform = require('vinyl-transform')
rename = require('gulp-rename')


gulp.task 'browserify', ->
  browserified = transform((filename) ->
    b = browserify(
      entries: filename
      extensions: [
        '.coffee'
        '.cjsx'
      ]
      debug: false
      cache: {}
      packageCache: {}
      fullPaths: false)
    b.bundle()
  )
  gulp.src([
    './src/app/app.coffee'
    './src/admin/admin.coffee'
  ])
  .pipe(browserified)
  .pipe(rename(extname: '.js'))
  .pipe(uglify())
  .pipe gulp.dest('./public/js/')