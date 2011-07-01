settings = require('./settings')

config = {}

config.adapter = :couch_model
config.cradle = {
   host: :localhost
   , port: 5984
   , auth: {
      username: ''
      , password: ''
   }
   , options: {
      cache: true
      , raw: false
   }
}

if settings.ENVIRONMENT is :development {
   
   config.cradle.options.cache = false
   //config.name = :my_app_name_development
   config.name = :bytor
   
} else if settings.ENVIRONMENT is :test {
   
   config.name = :my_app_name_test
   
} else if settings.ENVIRONMENT is :production {
   
   config.name = :my_app_name_production
   
}

module.exports = config