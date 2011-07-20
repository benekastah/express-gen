require('kaffeine');
var lib = require("./core/lib"),
npm = require("npm"),
meInfo = require("./core/me.info");
settings = require("settings");

desc("Tests to make sure jake is properly working for this project");
  task("test", function () {
    console.log("here!");
    console.log(arguments);
  });

desc("Initializes a new project");
  task('bundle', function (config) {
    config = config || {};
    
    var d, loc = [], glob = [];

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

desc("Updates " + meInfo.projectName + " or dependencies to newer versions or patch-levels.");
  task('update', function (what) {
    lib.git.pull(meInfo.projectName + " " + settings.UPDATEVERSION, function (what) {
      switch (what) {
        case "project":
          meInfo = require("./core/me.info");
          lib.git.exec("remote add " + meInfo.projectName + " " + meInfo.gitUrl);
          break;
      }
    });
  });

desc("Sets up project after creating a project or updating " + meInfo.projectName + ".");
  task("setup", function () {
    var config = getNamedArgs(arguments);
    lib.setUpInitialFiles(config);
  });


//------------------------------------------------------------------------------

function getNamedArgs(args) {
  var ret = {};
  for (var i=0, len=args.length; i<len; i++) {
    var arg = args[i];
    if (/\w+:\w+/.test(arg)) {
      arg = arg.split(":");
      name = arg[0];
      value = arg[1];
      ret[name] = value;
    }
  }
  return ret;
}
