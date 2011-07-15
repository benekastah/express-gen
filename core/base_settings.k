base_settings = {}

base_settings.APPROOT = process.cwd().replace /\/config$/, ''
base_settings.VIEWSDIR = "#{base_settings.APPROOT}/views"
base_settings.STATICDIR = "#{base_settings.APPROOT}/public"
base_settings.ENVIRONMENT = process.env.NODE_ENV || :development
base_settings.BASE_DEPENDENCIES = [
  :express,
  :fugue
]

module.exports = base_settings
