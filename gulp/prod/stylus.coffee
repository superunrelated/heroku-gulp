gulp = require('gulp')
stylus = require('gulp-stylus')
nib = require('nib')

gulp.task 'stylus', ->
  gulp.src('./src/stylus/main.styl')
    .pipe(sourcemaps.init())
    .pipe( 
      stylus(
        use: nib()
        compress: true 
      )
    )
    .pipe(gulp.dest('./public/css'))