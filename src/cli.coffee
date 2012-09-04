###!
* Snockets command-line interface.
*
* Joshua F. Rountree <rountrjf@uc.edu>
* MIT License.
###
###
Dependencies.
###
path = require("path")
flatiron = require("flatiron")
app = module.exports = require("./index")
error = console.error

app.use flatiron.plugins.cli,
  usage: ["Snockets from the CLI.", "", "Usage: snockets <command>"]
  source: path.join(__dirname, "commands")
  argv: {}

commands = require("./commands")
app.cmd /watch ([^\s]+) ([^\s]+)/, commands.watch
app.cmd /version/, commands.version

# Username only.
#app.cmd /([a-zA-Z0-9\-_]+)/, commands.issues

# Username + repo.
#app.cmd /([^\s]+) ([^\s]+)/, commands.issues

###
Handles exceptions.
###
process.on "uncaughtException", (err) ->
  error err.message
  process.exit 1
