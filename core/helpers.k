settings = require(:settings)

module.exports = {
   get_controller: (name) -> {
      require("#{settings.APPROOT}/mvc/controllers/#{name}_controller")
   },
   
   get_model: (name) -> {
      require("#{settings.APPROOT}/mvc/models/#{name}_model")
   }
}