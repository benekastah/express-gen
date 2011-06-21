constant = (name, value, base = this) -> {
   if constant.nameToUpper && (constName = name.toUpperCase()) !== name {
      err = "A constant's name may not contain any lowercase letters"
      if constant.onNameToUpper === :err
         throw new TypeError err
      else if constant.onNameToUpper === :warn
         warn "#{err}. #{name} has been converted to #{constName}"
   }
   
   base.__defineGetter__ constName, -> { value }
   base.__defineSetter__ constName, -> {
      err = "Cannot modify constant"
      if constant.onModify === :err
         throw new TypeError err
      else if constant.onModify === :warn:
         warn err
   }
}
constant.nameToUpper = true
constant.onNameToUpper = :warn
constant.onModify = :err
exports.constant = constant

exports.warn = (msg) -> {
   console.log "Warning: #{msg}"
}