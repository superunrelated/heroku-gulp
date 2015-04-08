gulp = require('gulp')
browserSync = require('browser-sync')

gulp.task('browsersync', ['build'], ->
  browserSync
    proxy: "http://localhost:3000"
    files: [
      'public/**'
      'src/server/**'
    ]
    logSnippet: false
    port: 3001
)