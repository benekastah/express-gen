settings = require :settings

class ApplicationController {
   @initialize = -> {
      for i, item in @ {
         if typeof item === :function {
            item.view = "#{@name}/#{i}"
         }
      }
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