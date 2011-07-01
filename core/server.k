
express = require :express
fugue = require :fugue
settings = require :settings
routes = require :routes
env_config = require :environment_config

start = -> {
   server = express.createServer()
   
   setUpEnvironment server
   setUpRoutes server
   
   if settings.ENVIRONMENT === :development
      server.listen settings.PORT
   else if settings.ENVIRONMENT === :production || settings.ENVIRONMENT === :test
      fugue.start server, settings.PORT, null, 1, {verbose: true}
      
   console.log "\nServer listening on port #{settings.PORT}\n"
}

setUpEnvironment = (server) -> {
   
   doConfigure = (server, config) -> {
      for item of config {
         method = item[0]
         args = item.splice 1
         server[method].apply(server, args)
      }
   }
   
   for name, config from env_config {
      ((config) -> {
         if name is :all {
            server.configure -> {
               doConfigure server, config
            }
         } else {
            server.configure name, -> {
               doConfigure server, config
            }
         }
      }).call(this, config)
   }
}

setUpRoutes = (server) -> {
   for i, item in routes {
      {
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
}

// Kick off the server!!
start()