# https://www.npmjs.org/package/gulp-rename
# todo rename dirs: scripts, source, iamges,styles, dest
# todo use template in template dir files

"use strict"
gulp = require("gulp")
$ = require("gulp-load-plugins")(config: __dirname + '/package.json') #plugins
slugify = require("underscore.string").slugify
inquirer = require("inquirer")

gulp.task "default", (done) ->
  inquirer.prompt require("./prompts.coffee"), (answers) ->
    return done()  unless answers.__continue
    answers.appNameSlug = slugify(answers.appName)
    d = new Date()
    answers.year = d.getFullYear()
    answers.date = d.getFullYear() + "-" + d.getMonth() + "-" + d.getDate()
    files = [
      __dirname + "/templates/**"
      "!" + __dirname + "/templates/node_modules/**"
      "!" + __dirname + "/templates/node_modules/"
      "!" + __dirname + "/templates/LICENSE_" + ((if (answers.license is "MIT") then "BSD" else "MIT"))
    ]
    answersLookup = (key) ->
      answers[key] or key

    gulp.src(files).pipe($.template(answers)).pipe($.rename((file) ->
      file.basename = file.basename.replace("LICENSE_" + answers.license, "LICENSE")
      file.dirname = file.dirname.replace(/\w*_dir/g, answersLookup)
      file.basename = file.basename.replace(/\w*_dir/g, answersLookup)
      file.basename = "." + file.basename.slice(1)  if file.basename[0] is "_"
      return
    )).pipe($.conflict("./")).pipe(gulp.dest("./")).pipe($.install()).on "end", done
    return

  return
