dbConfig = require :db_config
CouchModel = require(:couch_model) dbConfig

class ApplicationModel extends CouchModel {
   
   //@initialize = -> { super { name: @name } }
   
   /*
   * All models inherit from this class.
   */
   
}

module.exports = ApplicationModel
