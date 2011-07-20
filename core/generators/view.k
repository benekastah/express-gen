lib = require("../lib")
sys = require :sys
fs = require :fs
settings = require :settings
path = require :path

module.exports = (args) -> {
  tmp = args[1].split '/'
  viewDir = tmp[0]
  viewName = tmp[1]

  if !viewName {
    viewName = viewDir
    viewDir = ''
  }
  
  template = "#{settings.APPROOT}/core/templates/view.jade.template"
  targetDir = "#{settings.APPROOT}/mvc/views/#{viewDir}"
  target = path.normalize "#{targetDir}/#{viewName}.jade"

  lib.bash.exec! "mkdir -p #{targetDir}"
  
  sys.puts "Creating file #{target}"
  err = lib.renderToFile! template, target, {
    viewName: args[1],
    filePath: target,
  }

  if err, console.error "Error writing to \"#{target}\": #{err}"
  else sys.puts "Done."
}
