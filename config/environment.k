/*
*
*  This configuration is directly passed to express where [:use, list, of, args] maps to server.use(list, of, args)
*  See http://expressjs.com/guide.html#configuration for the express configuration documentation
*
*/

settings = require :settings

module.exports = {
   all: [
      [:set, :views, "#{settings.APPROOT}/mvc/views"]
      , [:set, 'view engine', :jade]
   ]
   
   , development: [
   
   ]
   
   , test: [
   
   ]
   
   , production: [
   
   ]
}