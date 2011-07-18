fs = require :fs
sys = require :sys
path = require :path
lib = require "../lib"

module.exports = (args) -> {
   text = fs.readFileSync "core/templates/update.template", :utf8

   version = args[0];
   
   template = new lib.GenTemplate { 
      text: text,
      replacements: {
         version: version
      }
   }
   
   file = "mvc/models/update.k"
   sys.puts "Creating file #{file}..."
   result = lib.writeFile! file, template.render()
   if result is true
      sys.puts "Done."
   else
      console.error "Error writing to file: #{result}"
}
