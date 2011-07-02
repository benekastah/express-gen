helpers = require(:helpers)

ApplicationModel = helpers.get_model :application

class GeneralChicken extends ApplicationModel {
   @initialize = -> {
      super({ name: "general_chicken" })
   }
}

module.exports = new GeneralChicken()