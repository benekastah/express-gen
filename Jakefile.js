require('kaffeine');
var lib = require("./core/lib"),
npm = require("npm");

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
