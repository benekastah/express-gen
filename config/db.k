// Config is for CouchDB using Cradle
module.exports = {
   common: {
      host: 'localhost'
      , auth: {
         username: 'Paul'
         , password: ''
      }
      , options: {
         cache: true
         , raw: false
      }
   }
   , development: {
      cache: false
   }
   , test: {
      
   }
   , production: {
      
   }
}