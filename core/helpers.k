settings = require :settings
lib = require "#{settings.APPROOT}/core/lib"

module.exports = {
   get_controller: (name) -> {
      require("#{settings.APPROOT}/mvc/controllers/#{lib.camelCaseToLower name}_controller")
   },
   
   get_model: (name) -> {
      require("#{settings.APPROOT}/mvc/models/#{lib.camelCaseToLower name}_model")
   }
}
