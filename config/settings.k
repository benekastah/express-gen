settings = require('../core/base_settings')

/* These settings represent defaults that can be overridden as needed.
settings.VIEWSDIR = "#{settings.APPROOT}/views"
settings.STATICDIR = "#{settings.APPROOT}/public"
//*/

// Connection info
settings.HOST = :localhost
settings.PORT = 7000

// General settings
settings.APPNAME = "My Node App"
settings.APPTITLE = settings.APPNAME

// Options for fugue. Only used in production or test
settings.WORKERS = 2


module.exports = settings