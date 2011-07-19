// This file should be modified before the user ever touches it, and it's purpose is
// to provide settings that are needed for basic operation until this file is regener-
// ated from the template. Editing of settings template in should be done in
// core/templates/settings.k.template.

settings = require('../core/base_settings')

/* These settings represent defaults that can be overridden as needed.
settings.VIEWSDIR = "#{settings.APPROOT}/views"
settings.STATICDIR = "#{settings.APPROOT}/public"
//*/

// Settings for updating %libraryName%
settings.UPDATEVERSION: "%version%"

// Connection info
settings.HOST = :localhost
settings.PORT = 7000

// General settings
settings.APPNAME = "%appName%"
settings.APPTITLE = settings.APPNAME

// Fugue stuff. Only used in production or test.
settings.WORKERS = 2

// Additional project requirements
settings.DEPENDENCIES = [
  //:qux
]

module.exports = settings
