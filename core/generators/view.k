lib = require("../lib")
sys = require :sys
fs = require :fs

module.exports = (args) -> {
  viewName = args[0]
  
  template = "core/templates/view.jade.template"
  targetDir = "mvc/views/#{viewName}"
  target = "#{targetDir}.jade"

  fs.mkdir! targetDir, 755
  
  sys.puts "Creating file #{target}"
  err = lib.renderToFile! template, target, {
    viewName: viewName,
    filePath: target,
  }

  if err, console.error "Error writing to \"#{target}\": #{err}"
  else sys.puts "Done."
}
