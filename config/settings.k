settings = require('../core/base_settings')

/* These settings represent defaults that can be overridden as needed.
settings.VIEWSDIR = "#{settings.APPROOT}/views"
settings.STATICDIR = "#{settings.APPROOT}/public"
//*/

// Settings for updating express-gen
settings.UPDATEVERSION = "undefined"

// Connection info
settings.HOST = :localhost
settings.PORT = 7000

// General settings
settings.APPNAME = "myDB,master"
settings.APPTITLE = settings.APPNAME

// Fugue stuff. Only used in production or test.
settings.WORKERS = 2

// Additional project requirements
settings.DEPENDENCIES = [
  //:qux
]

module.exports = settings
