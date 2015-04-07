gulp = require('gulp')
cjsx = require('gulp-cjsx')
browserify = require('browserify')
stylus = require('gulp-stylus')
nib = require('nib')
uglify = require('gulp-uglify')
gulpif = require('gulp-if')
transform = require('vinyl-transform')
rename = require('gulp-rename')


gulp.task 'prod', [
  'prodLogENV'
  'prodCJSX'
  'prodBrowserify'
  'prodCopy'
  'prodStylus'
  'jslibs'
]


gulp.task 'prodCJSX', ->
  gulp.src([
    './src/**/*.cjsx'
    './src/**/*.coffee'
  ])
  .pipe(cjsx(bare: true)
  .on('error', console.log))
  .pipe(gulp.dest('./server/'))


gulp.task 'prodCopy', ->
  gulp.src('./src/server/views/**').pipe gulp.dest('./server/server/views')
  gulp.src('./src/img/**').pipe gulp.dest('./public/img')
  gulp.src('src/stylus/fonts/**').pipe gulp.dest('public/css/fonts')
  gulp.src('src/assets/**').pipe gulp.dest('public/assets')
  return


gulp.task 'prodBrowserify', ->
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
    './src/app/main.coffee'
    './src/app/admin.coffee'
  ]).pipe(browserified).pipe(rename(extname: '.js')).pipe(gulpif(process.env.NODE_ENV == 'production', uglify())).pipe gulp.dest('./public/js/')