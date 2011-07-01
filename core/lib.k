
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