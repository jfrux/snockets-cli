###!
* Snockets command-line interface.
*
* Joshua F. Rountree <rountrjf@uc.edu>
* MIT License.
###
path = require("path")
app = module.exports = require("flatiron").app
app.config.file file: path.join(__dirname, "..", "data", "config.json")
#app.config.defaults reporter: "basic"