gulp = require('gulp')
browserSync = require('browser-sync')

gulp.task 'browserSync', ['build'], ->
  browserSync
    files: [
      'public/**'
      'src/server/**'
      './public/css'
    ]
    logSnippet: false
    port: 5675
  return
