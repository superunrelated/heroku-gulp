fs = require('fs')
gulp = require('gulp')
onlyScripts = require('./util/scriptFilter')

env = process.env.NODE_ENV || 'development'
console.log('--------------------------------------------')
console.log(' GULP is running in ' + env + ' mode')
console.log('--------------------------------------------')

common = fs.readdirSync('./gulp/common/').filter(onlyScripts)
common.forEach((task) ->
  require('./common/' + task)
)

# Prevent dev tasks and their dependencies from beeing 
# included in on the server. Dependencies for tasks in 
# the 'dev' folder should be added to 'devDependencies'.

switch env
  when 'development'
    dev = fs.readdirSync('./gulp/dev/').filter(onlyScripts)
    dev.forEach((task) ->
      require('./dev/' + task)
    )
  when 'production'
    prod = fs.readdirSync('./gulp/prod/').filter(onlyScripts)
    prod.forEach((task) ->
      require('./prod/' + task)
    )

gulp.task('list', -> 
  if dev
    list = common.concat(dev)
  if prod
    list = common.concat(prod)

  console.log('--------------------------------------------')
  console.log(' TASKS')
  list.forEach((task) ->
    console.log('   ' + task.replace('.coffee', '') )
  )
  console.log('--------------------------------------------')
)