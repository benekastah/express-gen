
sys = require :sys
lib = require '../core/lib'
util = require :util
meInfo = require '../core/me.info'

cwd = process.cwd()
gitUrl = meInfo.gitUrl
args = new lib.ArgumentList process.argv, 2

project = args[0].split '@'
projectDir = "#{cwd}/#{project[0]}"
checkoutItem = project[1];

{
  lib.git.clone! gitUrl, projectDir
  checkoutItem = getCheckoutItem checkoutItem
  sys.puts checkoutItem
  
  lib.git.checkout! checkoutItem
  remote = lib.git.exec! "remote add #{meInfo.projectName} #{gitUrl}"
  sys.puts remote
  
  bundle = lib.bash.exec! "jake bundle"
  sys.puts bundle

  versionKey = meInfo.projectName + "_version"
  setup = lib.bash.exec! "jake setup[{\"#{versionKey}\" : \"#{checkoutItem}\"}]"
  sys.puts setup
}

//-----------------------------------------------------------------------------

function getCheckoutItem(item = 'release') {
   process.chdir projectDir
   
   if /^v?\d+\.\d+\.\d+\-*\w*/.test checkoutItem {
      return "tags/v#{item.replace /^v/, ''}"
   } else if item !== :master && item !== :stable {
      out = lib.git.exec! "tag -l"
      tags = out.split "\n"
      
      latest = { major: 0, minor: 0, patch: 0 }
      for tag, i of tags {
         if !tag, continue
         tagObj = tag.replace(/^v/, '').split(/\.|\-/)
         tags[i] = { major: tagObj[0], minor: tagObj[1], patch: tagObj[2], flag: tagObj[3], text: tag }
         
         // Determine the latest version with their selected flag
         if tags[i].flag === item
            && (tags[i].major > latest.major
            || (tags[i].major === latest.major && tags[i].minor > latest.minor
            || (tags[i].minor === latest.minor && tags[i].patch > latest.patch)))
            latest = tags[i]
      }
      return "tags/#{latest.text}"
   } else
      return item
}
