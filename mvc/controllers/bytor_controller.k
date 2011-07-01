helpers = require :helpers

ApplicationController = helpers.get_controller :application

class Bytor extends ApplicationController {
   @name = :bytor
   @bytor = helpers.get_model(:bytor)
   
   @index = -> {
      @render @index, {name: @bytor.info.here}
   }
   
}

module.exports = new Bytor()