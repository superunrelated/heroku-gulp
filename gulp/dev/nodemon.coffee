gulp = require('gulp')
nodemon = nodemon = require('gulp-nodemon')

args = process.argv.slice(2)
onlyServer = args.indexOf('--server') isnt -1

# Default ignore filter
ignore = [
  'node_modules'
  'newrelic_agent.log'
  '.git/**'
  'src/assets/**'
  'src/img/**'
  'src/sass/**'
  'public/**'
  'src/stylus/**'
  'src/server/views/**/*.jade'
  'src/app/**/*.coffee'
]

# Add ignore of frontend .cjsx files, no need to restart server when only doing frontend work
if onlyServer
  console.log 'Ignoring frontend rebuilds'
  ignore.push 'src/app/**/*.cjsx'

gulp.task('nodemon', ->
  nodemon(
    verbose: true
    script: './gulp/dev/nodemon-cjsx.coffee'
    ext: 'coffee jsx cjsx'
    env:
      DEBUG: 'stollek:*'
      NODE_ENV: 'development'
    ignore: ignore
  )
  .on('start', () ->

  )
  .on('restart', () ->
    console.log("-- RESTART")
  )
)