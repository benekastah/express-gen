module.exports = (args) -> {
  viewName = args[0]
  
  template = "core/templates/view.jade.template"
  target = "mvc/views/#{viewName}.jade

  sys.puts "Creating file #{target}"
  err = lib.renderToFile! template, target, {
    viewName: viewName,
    filePath: target,
  }

  if err, console.error "Error writing to \"#{target}\": #{err}"
  else sys.puts "Done."
}
