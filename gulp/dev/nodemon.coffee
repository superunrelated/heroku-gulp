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
    script: './gulp/util/nodemon-cjsx.coffee'
    ext: 'coffee jsx cjsx'
    env:
      DEBUG: 'herokugulp:*'
      NODE_ENV: 'development'
      PORT: 3000
    ignore: ignore
  )
  .on('start', () ->
    # console.log("-- START")
  )
  .on('restart', () ->
    console.log("-- RESTART")
  )
)