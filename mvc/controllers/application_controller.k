settings = require :settings

class ApplicationController {
   @initialize = -> {
      for i, item in @ {
         if typeof item === :function {
            @[i] = item.bind @ // Temp fix for a wierd scope problem
            @[i].view = "#{@name}/#{i}"
         }
      }
      
      try {
        @[@name] = helpers.get_model @name
      } catch (e) { /* No model */ }
   }
   
   @render = (view, locals, layout) -> {
      if (typeof view !== :string)
         view = view.view
      
      locals = locals || {}
      locals.title = locals.title || settings.APPTITLE
      layout = layout || @default_layout
      
      {  view: view
         , locals: locals
         , layout: layout  }
   }
}

module.exports = ApplicationController
