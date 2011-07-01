helpers = require(:helpers)

ApplicationModel = helpers.get_model :application

class Bytor extends ApplicationModel {
   @initialize = -> {
      super({ name: :vader })
   }
}

bytor = new Bytor()
module.exports = bytor