fs = require :fs
sys = require :sys
path = require :path
lib = require "../lib"

module.exports = (args) -> {
   text = fs.readFileSync "core/templates/model.template", :utf8
   
   modelClassName = lib.lowerCaseToCamel args[1], true
   modelName = lib.camelCaseToLower modelClassName
   
   template = new lib.GenTemplate { 
      text: text,
      replacements: [
         [:modelClassName, modelClassName],
         [:modelName, modelName]
      ]
   }
   
   file = "mvc/models/#{modelName}_model.k"
   sys.puts "Creating file #{file}..."
   result = lib.writeFile! file, template.render()
   if result is true
      sys.puts "Done."
   else
      console.error "Error writing to file: #{result}"
}