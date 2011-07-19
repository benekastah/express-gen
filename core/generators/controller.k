fs = require :fs
sys = require :sys
path = require :path
lib = require "../lib"

module.exports = (args) -> {
  template = "core/templates/controller.template"
  targetFile = "mvc/controllers/#{modelName}_controller.k"

  sys.puts "Creating file #{targetFile}..."
  err = lib.renderToFile! template, targetFile, {
    controllerClassName: lib.lowerCaseToCamel(args[1], true),
    modelName: lib.camelCaseToLower(controllerClassName),
  }

  if err, console.error "Error writing to file: #{err}"
  else sys.puts "Done."
}
