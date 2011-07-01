fs = require :fs
sys = require :sys
path = require :path
lib = require "../lib"

module.exports = (args) -> {
   text = fs.readFileSync "core/templates/model.template", :utf8
   
   modelClassName = args[1].name
   modelName = lib.camelCaseToLower(modelClassName)
   
   template = new lib.GenTemplate { 
      text: text,
      replacements: [
         [:modelClassName, modelClassName],
         [:modelName, modelName]
      ]
   }
   
   file = "mvc/models/#{modelName}_model.k"
   exists = path.existsSync file
   
   if not exists {
      wStream = fs.createWriteStream file, { mode: 0755 }
      wStream.addListener :error, (err) -> {
         throw err
      }
      
      if wStream.write(template.render())
         sys.puts "Created #{file}"
   }
}