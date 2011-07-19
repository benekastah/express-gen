fs = require :fs
sys = require :sys
path = require :path
lib = require "../lib"

module.exports = (args) -> {
  template = "core/templates/model.template"
  targetFile = "mvc/models/#{modelName}_model.k"

  sys.puts "Creating file #{targetFile}..."
  err = lib.renderToFile! template, targetFile, {
    modelClassName: lib.lowerCaseToCamel(args[1], true),
    modelName: lib.camelCaseToLower(modelClassName),
  }

  if err, console.error "Error writing to file: #{err}"
  else sys.puts "Done."
}
