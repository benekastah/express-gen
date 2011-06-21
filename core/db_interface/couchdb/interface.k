dbConfig = require('../../../config/db')
cradle = require(:cradle)

cradle.setup {
   host: dbConfig.common.host
}