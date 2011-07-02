fs = require :fs
sys = require :sys
path = require :path
lib = require "../lib"

module.exports = (args) -> {
   text = fs.readFileSync "core/templates/controller.template", :utf8
   
   controllerClassName = lib.lowerCaseToCamel args[1], true
   modelName = lib.camelCaseToLower(controllerClassName)
   
   template = new lib.GenTemplate { 
      text: text,
      replacements: [
         [:controllerClassName, controllerClassName],
         [:modelName, modelName]
      ]
   }
   
   file = "mvc/controllers/#{modelName}_controller.k"
   sys.puts "Creating file #{file}..."
   result = lib.writeFile! file, template.render()
   if result is true
      sys.puts "Done."
   else
      console.error "Error writing to file: #{result}"
}