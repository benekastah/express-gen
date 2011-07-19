path = require :path
fs = require :fs
settings = require :settings
sys = require :sys
exec = require('child_process').exec
meInfo = require "./me.info"

emptyFn = -> {}

exports.camelCaseToLower = (string) -> {
   ret = '';
   for item, i of string {
      if i is 0, ret += item.toLowerCase()
      else if item.toUpperCase() is item
         ret += '_' + item.toLowerCase()
      else
         ret += item
   }
   return ret;
}

exports.lowerCaseToCamel = (string, capitalizeFirstLetter) -> {
   ret = '';
   capitalizeNext = !!capitalizeFirstLetter
   for item, i of string {
      if item is '_', capitalizeNext = true
      else if capitalizeNext {
         ret += item.toUpperCase()
         capitalizeNext = false
      } else
         ret += item
   }
   return ret
}

exports.switchCase = (string, capitalizeFirstLetter) -> {
   if string.toLowerCase() === string
      return exports.lowerCaseToCamel string, capitalizeFirstLetter
   else
      return exports.camelCaseToLower string
}

exports.GenTemplate = class GenTemplate {
   @initialize = (config) -> {
      @text = config.text
      @replacements = config.replacements
   }
   
   @render = -> {
      for key, item from @replacements {
         regExp = new RegExp "%#{key}%", "g"
         @text = @text.replace(regExp, item)
      }
      @text
   }
   
   replaceValue = (name, value) -> {
      regExp = new RegExp "%#{name}%", "g"
      @text.replace(regExp, value);
   }
   
   @toString = -> {
      @text
   }
}

exports.render = (template, replacements, _return) -> {
  err, text = fs.readFile! template, :utf8
  if err and _return, _return err, null
  t = new exports.GenTemplate {
    text: text,
    replacements: replacements || {}
  }
  if _return
    _return null, t.render()
}

exports.renderToFile = (template, targetFile, replacements, _return) -> {
  err, fileText = exports.render! template, replacements
  if err and _return, _return err

  err = lib.writeFile! targetFile, fileText
  if _return
    _return err
}

exports.writeFile = (file, data, _return) -> {
   file = "#{settings.APPROOT}/#{file}"
   err, exists = path.exists! file
   if (err) { _return err; return }
   
   if not exists {
      wStream = fs.createWriteStream file, { mode: 0755 }
      wStream.addListener :error, (err) -> {
         _return err
      }
      
      if wStream.write(data)
         _return true
   }
}

var array = []
class ArgumentList extends array {
   @initialize = (args, start) -> {
      if start and start > 0
         args = args.splice start
      
      @named = {}
      for arg, i of args {
         newArg = new Argument arg
         if newArg.value !== undefined
            @named[newArg.name] = newArg.value;
         else
            @push(newArg.name)
      }
   }
}
exports.ArgumentList = ArgumentList

class Argument {
   @initialize = (str) -> {
      if (typeof str !== :string)
         return;
         
      split = str.split ':'
      @name = split[0]
      @value = split[1]
   }
}

exports.git = {
   clone: (url, targetDir = '', _return = emptyFngit ) -> {
      command = "clone #{url} #{targetDir}"
      output = this.exec! command
      console.log output || ''
      _return(output)
   },
   
   checkout: (item, _return = emptyFn) -> {
      command = "checkout #{item}"
      output = this.exec! command
      console.log output || ''
      _return(output)
   },

   push: (to = '', at = '', _return = emptyFn) -> {
      command = "push #{to} #{at}".trim()
      output = this.exec! command
      console.log output || ''
      _return(output)
   },

   pull: (from = '', _return = emptyFn) -> {
      command = "pull #{from}".trim()
      output = this.exec! command
      console.log output || ''
      _return(output)
   },
   
   exec: (command, _return = emptyFn) -> {
      out = exports.bash.exec! "git #{command}"
      _return out
   },
}

exports.bash = {
   exec: (command, _return = emptyFn) -> {
      err, stdout, stderr = exec! command
      if (stderr) console.error stderr
      if (err) console.error err
      _return stdout
   }
}

exports.setUpInitialFiles = (config) -> {

  makeFileFromTemplate "settings.k.template", :config, {
    libraryName: meInfo.projectName,
    version: config[meInfo.projectName + "-version"],
    appName: config.appName,
  }


  //--------------------------------------------------------------------------

  function makeFileFromTemplate(templateName, targetPath, replacements, _return) {
    template = getTemplatePath templateName
    target = getTargetPath targetPath, templateName

    lib.renderToFile! template, target, replacements
    if _return
      _return.apply arguments

    function getTemplatePath(templateName) {
      "#{settings.APPROOT}/core/templates/#{templateName}"
    }

    function getTargetPath(path, templateName) {
      path = path.replace /\//, ''
      targetName = templateName.replace /\.template/, ''
      "#{settings.APPROOT}/#{path}/#{targetName}"
    }

    return
  }

  return
}
