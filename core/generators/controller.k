sys = require :sys
lib = require "../lib"

module.exports = (args) -> {
  controllerClassName = lib.lowerCaseToCamel(args[1], true)
  modelName = lib.camelCaseToLower(controllerClassName)
  
  template = "#{settings.APPROOT}/core/templates/controller.k.template"
  targetFile = "#{settings.APPROOT}/mvc/controllers/#{modelName}_controller.k"

  sys.puts "Creating file #{targetFile}..."
  err = lib.renderToFile! template, targetFile, {
    controllerClassName: controllerClassName,
    modelName: modelName,
  }

  if err, console.error "Error writing to file: #{err}"
  else sys.puts "Done."
}
