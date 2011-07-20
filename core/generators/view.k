lib = require("../lib")
sys = require :sys
fs = require :fs
settings = require :settings

module.exports = (args) -> {
  viewName = args[1]
  
  template = "#{settings.APPROOT}/core/templates/view.jade.template"
  targetDir = "#{settings.APPROOT}/mvc/views/#{viewName}"
  target = "#{targetDir}.jade"

  lib.mkdirP! targetDir, null
  
  sys.puts "Creating file #{target}"
  err = lib.renderToFile! template, target, {
    viewName: viewName,
    filePath: target,
  }

  if err, console.error "Error writing to \"#{target}\": #{err}"
  else sys.puts "Done."
}
