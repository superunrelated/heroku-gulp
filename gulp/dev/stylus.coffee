gulp = require('gulp')
stylus = require('gulp-stylus')
nib = require('nib')
sourcemaps = require('gulp-sourcemaps')

gulp.task('stylus', ->
  gulp.src('./src/stylus/main.styl')
    .pipe(sourcemaps.init())
    .pipe( 
      stylus(
        use: nib()
        compress: false 
      )
    )
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./public/css'))
)