sys = require :sys
lib = require "../lib"

module.exports = (args) -> {
  modelClassName = lib.lowerCaseToCamel(args[1], true)
  modelName = lib.camelCaseToLower(modelClassName)
  
  template = "core/templates/model.k.template"
  targetFile = "mvc/models/#{modelName}_model.k"

  sys.puts "Creating file #{targetFile}..."
  err = lib.renderToFile! template, targetFile, {
    modelClassName: modelClassName,
    modelName: modelName,
  }

  if err, console.error "Error writing to file: #{err}"
  else sys.puts "Done."
}
