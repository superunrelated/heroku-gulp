# This file adds node-cjsx for nodemon.
# TODO: Can the node-cjsx transform be added to Nodemon in a different maner?

require('node-cjsx').transform()
require('../../src/server/main.coffee')