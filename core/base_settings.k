
exports.APPROOT = process.cwd().replace /\/config$/, ''
exports.VIEWSDIR = "#{exports.APPROOT}/views"
exports.STATICDIR = "#{exports.APPROOT}/public"
exports.ENVIRONMENT = process.env.NODE_ENV || :development