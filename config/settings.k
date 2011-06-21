base_settings = require('../core/base_settings')
for name, value in base_settings
   exports[name] = value

/* These settings represent defaults that can be overridden as needed.
exports.VIEWSDIR = "#{exports.APPROOT}/views"
exports.STATICDIR = "#{exports.APPROOT}/public"
//*/

// Options for fugue. Only used in production or test
exports.PORT = 7000
exports.WORKERS = 1
exports.HOST = null