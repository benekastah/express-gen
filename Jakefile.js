require('kaffeine');
var lib = require("./core/lib"),
npm = require("npm"),
meInfo = require("./core/me.info");

desc("Initializes a new project");
task('bundle', function (config) {
  config = config || {};
  
  var settings = require('settings'),
  d, loc = [], glob = [];

  d = settings.BASE_DEPENDENCIES.concat(settings.DEPENDENCIES);

  for (var i=0, len=d.length; i<len; i++) {
    var item = d[i];
    if (!(item instanceof Object)) item = { name: item };
    
    try { require(item.name); } catch(e) {
      if (item.glob)
        glob.push(item.name);
      else
        loc.push(item.name)
    }
  }

  npm.load(function (err) {
    if (err) throw err;

    if (loc.length > 0) {
      console.log("Installing locally: " + loc.join());
      
      npm.commands.install(loc, function (err, data) {
        if (err)  throw err;
        if (data) console.log(data);
      });
    }
  });

  // Global installation not working yet. Still just does local.
  npm.load(function (err) {
    if (err) throw err;
    
    if (glob.length > 0) {
      console.log("Installing globally: " + glob.join());
      npm.config.set("global", true);
      
      npm.commands.install(glob, function (err, data) {
        if (err)  throw err;
        if (data) console.log(data);
      });
    }
  });
});

desc("Update " + meInfo.name + " to newer versions or patch-levels.");
task('update:' + meInfo.name, function () {
  lib.git.pull(meInfo.name, function () {
    meInfo = require("./core/me.info");
    lib.git.exec("remote add " + meInfo.projectName + " " + meInfo.gitUrl);
  });
});

desc("test task");
task("test", function () {
  console.log("here!");
  console.log(arguments);
})
