
express = require :express
fugue = require :fugue
settings = require '../config/settings'
routes = require '../config/routes'

start()

function start () {
   console.log arguments
   server = express.createServer()

   server.configure -> {
     server.use express.static "#{settings.APPROOT}#{settings.STATICDIR}"
     server.set :views, "#{settings.APPROOT}/mvc/views"
     server.set 'view engine', :jade
   }

   server.configure :development, -> {

   }

   server.configure :production, -> {

   }

   for i in routes {
      {
         item = routes[i]
         method = item[0]
         route = item[1]
         action = item[2]

         server[method] route, (req, res) -> {
            out = typeof action is :function ? action() : action

            if out.constructor is Object {
               if out.layout == null
                  out.locals.layout = "layouts/application"
               else
                  out.locals.layout = "layouts/#{out.layout}"

               res.render out.view, out.locals
            } else
               res.send out
         }
      }
   }

   if settings.ENVIRONMENT === :development
      server.listen settings.PORT
   else if settings.ENVIRONMENT === :production || settings.ENVIRONMENT === :test
      fugue.start server, settings.PORT, null, 1, {verbose: true}

   console.log "Server listening on port #{settings.PORT}"
}