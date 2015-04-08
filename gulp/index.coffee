fs = require('fs')
gulp = require('gulp')
onlyScripts = require('./util/scriptFilter')

env = process.env.NODE_ENV || 'development'
console.log('--------------------------------------------')
console.log(' GULP is running in ' + env + ' mode')
console.log('--------------------------------------------')

tasks = fs.readdirSync('./gulp/common/').filter(onlyScripts)
tasks.forEach((task) ->
  require('./common/' + task)
)

# Prevent dev tasks and their dependencies from beeing 
# included in on the server. Dependencies for tasks in 
# the 'dev' folder should be added to 'devDependencies'.

switch env
  when 'development'
    tasks = fs.readdirSync('./gulp/dev/').filter(onlyScripts)
    tasks.forEach((task) ->
      require('./dev/' + task)
    )
  when 'production'
    tasks = fs.readdirSync('./gulp/prod/').filter(onlyScripts)
    tasks.forEach((task) ->
      require('./prod/' + task)
    )