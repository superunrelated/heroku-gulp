gulp = require('gulp')
stylus = require('gulp-stylus')
nib = require('nib')
sourcemaps = require('gulp-sourcemaps')
gulpif = require('gulp-if')

gulp.task('stylus', ->
  gulp.src('./src/stylus/main.styl')
    .pipe(gulpif(process.env.NODE_ENV is 'development', sourcemaps.init()))
    .pipe( 
      stylus(
        use: nib()
        compress: process.env.NODE_ENV is 'production' 
      )
    )
    .pipe(gulpif(process.env.NODE_ENV is 'development', sourcemaps.write()))
    .pipe(gulp.dest('./public/css'))
)