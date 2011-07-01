helpers = require(:helpers)

ApplicationModel = helpers.get_model :application

class ThingAWic extends ApplicationModel {
   @initialize = -> {
      super({ name: "thing_a_wic" })
   }
}

module.exports = new ThingAWic()