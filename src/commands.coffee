###!
* Snockets command-line interface.
*
* Joshua F. Rountree <rountrjf@uc.edu>
* MIT License.
###
app = require('./index')
print = console.log
path = require("path")
Snockets = require 'snockets'
snockets = new Snockets()
watch = require('nodewatch')
fs = require "fs"
commands = module.exports

concatThem = (sourceFile,buildFile) ->
    print 'compiling ' + sourceFile
    snockets.getConcatenation sourceFile, minify: false, (err, js) ->
        #print 'errors: ' + err
        #print 'output: ' + js
        if err
            print err
        
        if js
            fs.writeFile buildFile, js, (err) ->
                if err
                    print err
                else
                    print "compiled " + sourceFile


###
Prints current version.

@api public
###
commands.version = ->
  print require("../package.json").version

commands.watch = (sourceFile,buildFile) ->
    snockets.getCompiledChain sourceFile, (err, jsList) ->
        watch.add(sourceFile).onChange (file,prev,curr,action) ->
            #print 'changed ' + file + ' (' + curr.mtime.getTime() + ')'
            #print 'compiling ' + sourceFile
            concatThem(sourceFile,buildFile)
        
        concatThem(sourceFile,buildFile)
        
        for jsFile in jsList
            do (jsFile) ->
                watch.add(jsFile).onChange (file,prev,curr,action) ->
                    #concatThem(sourceFile,buildFile)