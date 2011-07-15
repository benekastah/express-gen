path = require :path
fs = require :fs
settings = require :settings
sys = require :sys
exec = require('child_process').exec
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
      for item of @replacements {
         regExp = new RegExp "%#{item[0]}%", "g"
         @text = @text.replace(regExp, item[1])
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
   clone: (url, targetDir = '', _return = emptyFn) -> {
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
